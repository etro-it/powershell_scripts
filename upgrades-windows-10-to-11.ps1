# This scripts an automated upgrade of Windows 10 to Windows 11
# Define the file paths and URLs
$logFile = "C:\ETRO_pp\apps\Windows11UpgradeLog.txt"
# URL to download Windows 11 Installation Assistant
$windows11DownloadUrl = "https://download.microsoft.com/download/6/8/3/683178b7-baac-4b0d-95be-065a945aadee/Windows11InstallationAssistant.exe"
# Windows 11 official ISO page
$windows11IsoUrl = "https://www.microsoft.com/en-us/software-download/windows11"
# Log function to write to log file
Function Write-Log {
    param ([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "$timestamp - $Message"
    # Write message to log file and output to console
    Add-Content -Path $logFile -Value $logMessage
    # Write-Host $logMessage
}
# Function to download Windows 11 Installation Assistant
Function Download-Windows11Installer {
    Write-Log "Downloading Windows 11 Installation Assistant..."
    $installerPath = "C:\ETRO_pp\apps\Windows11Setup.exe"
    try {
        Invoke-WebRequest -Uri $windows11DownloadUrl -OutFile $installerPath
        Write-Log "Windows 11 Installation Assistant downloaded successfully at $installerPath."
        return $installerPath
    } catch {
        Write-Log "Failed to download Windows 11 Installation Assistant. Error: $_"
        return $null
    }
}
# Function to run the Windows 11 upgrade silently
Function Upgrade-Windows11 {
    param ([string]$installerPath)
    Write-Log "Initiating Windows 11 upgrade..."
    $installerLogPath = "C:\ETRO_pp\apps\"
    if ($installerPath -ne $null) {
        Write-Log "Starting the upgrade process..."
        Start-Process -FilePath $installerPath -ArgumentList "/quietinstall /skipeula /auto upgrade /copylogs $installerLogPath" -NoNewWindow -Wait
        Write-Log "Windows 11 upgrade process started."
    } else {
        Write-Log "Installer path is invalid, upgrade aborted."
    }
}
# Function to monitor upgrade status
Function Monitor-UpgradeStatus {
    Write-Log "Monitoring upgrade status..."
    # Checking for the setup process
    $process = Get-Process -Name "setup" -ErrorAction SilentlyContinue
    if ($process) {
        Write-Log "Upgrade process is running..."
        while ($process.HasExited -eq $false) {
            Write-Log "Upgrade still in progress..."
            Start-Sleep -Seconds 30
            $process = Get-Process -Name "setup" -ErrorAction SilentlyContinue
        }
        Write-Log "Upgrade process completed successfully."
    } else {
        Write-Log "No upgrade process found. Ensure the upgrade was initiated."
    }
}
# Main logic
Write-Log "Windows 11 upgrade script started."
$installerPath = Download-Windows11Installer
    if ($installerPath -ne $null) {
        # Step 3: Start the upgrade process silently
        Upgrade-Windows11 -installerPath $installerPath
        # Step 4: Monitor the upgrade process
        Monitor-UpgradeStatus
    } else {
        Write-Log "Failed to download Windows 11 installer. Upgrade aborted."
    }
Write-Log "Windows 11 upgrade script finished."
