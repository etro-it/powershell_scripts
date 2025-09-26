param(
    [string]$RootPath = "C:\"  # Default drive root
)

Write-Host "Scanning $RootPath ... This may take a while." -ForegroundColor Cyan

function Get-FolderSize {
    param([string]$Path)

    $size = 0
    try {
        Get-ChildItem -LiteralPath $Path -Recurse -File -ErrorAction SilentlyContinue |
            ForEach-Object { $size += $_.Length }
    }
    catch {
        # Ignore access errors quietly
    }
    return $size
}

$results = @()

# Root-level files
$rootFileSize = (Get-ChildItem -LiteralPath $RootPath -File -ErrorAction SilentlyContinue | Measure-Object Length -Sum).Sum
if (-not $rootFileSize) { $rootFileSize = 0 }
$results += [PSCustomObject]@{ Folder = "$RootPath (files only)"; SizeBytes = $rootFileSize }

# Top-level folders
Get-ChildItem -LiteralPath $RootPath -Directory -ErrorAction SilentlyContinue | ForEach-Object {
    $size = Get-FolderSize -Path $_.FullName
    $results += [PSCustomObject]@{ Folder = $_.FullName; SizeBytes = $size }
}

# Output sorted summary
$results |
    Sort-Object SizeBytes -Descending |
    Select-Object Folder,
                  @{Name="Size(GB)"; Expression={[math]::Round($_.SizeBytes / 1GB, 2)}},
                  @{Name="Size(MB)"; Expression={[math]::Round($_.SizeBytes / 1MB, 2)}},
                  @{Name="Size(Bytes)"; Expression={$_.SizeBytes}} |
    Format-Table -AutoSize
