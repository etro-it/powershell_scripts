$FilePath = "c:\users\brad.janzen_etrocons\AppData\Local\Temp\odis_download_dest\1ef6-0be3-3310-f495\setup\AdskUpdateCheck.exe"
if (-Not (Test-Path $FilePath)) {
    Write-Error "File '$FilePath' not found."
    exit 1
}

$signature = Get-AuthenticodeSignature -FilePath $FilePath

if ($signature.SignerCertificate -ne $null) {
    $cert = $signature.SignerCertificate
    Write-Output "Signature Status   : $($signature.Status)"
    Write-Output "Signer Subject     : $($cert.Subject)"
    Write-Output "Issuer             : $($cert.Issuer)"
    Write-Output "Valid From         : $($cert.NotBefore)"
    Write-Output "Valid To           : $($cert.NotAfter)"
    Write-Output "Thumbprint         : $($cert.Thumbprint)"
    Write-Output "Serial Number      : $($cert.SerialNumber)"
    Write-Output "Signature Algorithm: $($cert.SignatureAlgorithm.FriendlyName)"
} else {
    Write-Output "The file is not signed or the signature could not be retrieved."
}
