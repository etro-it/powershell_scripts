# Get all installed AppX packages
Get-AppxPackage | Select-Object Name, Version | Format-Table -AutoSize
