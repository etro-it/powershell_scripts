param(
    [Parameter(Mandatory=$true)]
    [string]$FilePath
)

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
