# Get all installed AppX packages
$allPackages = Get-AppxPackage

# Filter out Microsoft packages
$nonMicrosoftPackages = $allPackages | Where-Object { $_.Publisher -notlike "*Microsoft*" }

# Display results
if ($nonMicrosoftPackages) {
    $nonMicrosoftPackages | Select-Object Name, Publisher, Version | Format-Table -AutoSize
} else {
    Write-Host "No non-Microsoft Appx packages found."
}
