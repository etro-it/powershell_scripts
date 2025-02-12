# Get all installed AppX packages
Get-AppxPackage | Select-Object Name, Publisher, Version | Format-Table -AutoSize
