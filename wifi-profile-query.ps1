# Define variables
$ProfileName = "etro-temp"
$OutputFile  = "C:\etro_pp\apps\wifi-not-updated.txt"

# Check if Wi-Fi profile exists
$ProfileExists = netsh wlan show profiles | Select-String -Pattern ":\s*$ProfileName$"

if (-not $ProfileExists) {
    # Ensure directory exists
    $Directory = Split-Path $OutputFile
    if (-not (Test-Path $Directory)) {
        New-Item -ItemType Directory -Path $Directory -Force | Out-Null
    }

    # Write to file
    "the wifi profile named etro-temp was not found." | Out-File -FilePath $OutputFile -Encoding UTF8
}
