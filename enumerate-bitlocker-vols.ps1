# Ensure the BitLocker module is available
if (-not (Get-Command Get-BitLockerVolume -ErrorAction SilentlyContinue)) {
    Write-Host "The BitLocker module is not available on this system." -ForegroundColor Red
    return
}

# Get all volumes, even if not encrypted
$volumes = Get-BitLockerVolume

foreach ($volume in $volumes) {
    $mountPoint = $volume.MountPoint
    $status = $volume.VolumeStatus
    $encryption = $volume.EncryptionPercentage

    Write-Host "Drive: $mountPoint"
    Write-Host "  Status: $status"
    Write-Host "  Encryption: $encryption%" -ForegroundColor Cyan
    Write-Host ""
}
