# Check TPM 2.0 status
Write-Host "Checking TPM 2.0 status..." -ForegroundColor Cyan
$TPM = Get-WmiObject -Namespace "Root\CIMv2\Security\MicrosoftTpm" -Class Win32_Tpm

if ($TPM -and $TPM.SpecVersion -match "2.0" -and $TPM.IsEnabled_InitialValue -and $TPM.IsActivated_InitialValue) {
    Write-Host "TPM 2.0 is present, enabled, and activated." -ForegroundColor Green
} else {
    Write-Host "TPM 2.0 is not properly configured or not present." -ForegroundColor Red
}

# Check Secure Boot status
Write-Host "`nChecking Secure Boot status..." -ForegroundColor Cyan
$SecureBoot = Confirm-SecureBootUEFI

if ($SecureBoot -eq $true) {
    Write-Host "Secure Boot is enabled." -ForegroundColor Green
} elseif ($SecureBoot -eq $false) {
    Write-Host "Secure Boot is disabled." -ForegroundColor Red
} else {
    Write-Host "Secure Boot status cannot be determined (system might not support UEFI or script not running as admin)." -ForegroundColor Yellow
}
