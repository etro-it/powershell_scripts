# Parameters
$subnet = "192.168.1"     # Set your subnet (omit the last octet)
$ports = @(80, 443)   # List of TCP ports to scan
$timeout = 1000           # Timeout in milliseconds

# Output file (optional)
$outputFile = "c:\etro_pp\apps\port_scan_results.txt"
"" | Out-File $outputFile

# Scan
foreach ($i in 1..254) {
    $ip = "$subnet.$i"
    foreach ($port in $ports) {
        $result = Test-NetConnection -ComputerName $ip -Port $port -WarningAction SilentlyContinue
        if ($result.TcpTestSucceeded) {
            $msg = "[+] Open: $ip : $port"
            Write-Output $msg
            $msg | Out-File $outputFile -Append
        } else {
            Write-Host "[-] Closed: $ip : $port" -ForegroundColor DarkGray
        }
    }
}
