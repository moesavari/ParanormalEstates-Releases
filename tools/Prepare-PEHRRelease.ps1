param(
    [Parameter(Mandatory=$true)][string]$BuildFolder,
    [Parameter(Mandatory=$true)][string]$Version,
    [string]$OutputFolder = ".\\dist"
)

$ErrorActionPreference = "Stop"

if ($Version -notmatch '^\\d+\\.\\d+\\.\\d+$') {
    throw "Version must look like 0.4.0"
}

$resolvedBuild = (Resolve-Path $BuildFolder).Path
New-Item -ItemType Directory -Force -Path $OutputFolder | Out-Null
$resolvedOutput = (Resolve-Path $OutputFolder).Path
$zipName = "PEHR-$Version-Windows.zip"
$zipPath = Join-Path $resolvedOutput $zipName

if (Test-Path $zipPath) { Remove-Item $zipPath -Force }

Write-Host "Packaging $resolvedBuild"
Compress-Archive -Path (Join-Path $resolvedBuild '*') -DestinationPath $zipPath -CompressionLevel Optimal

$hash = (Get-FileHash -Path $zipPath -Algorithm SHA256).Hash.ToLowerInvariant()
$size = (Get-Item $zipPath).Length

Write-Host ""
Write-Host "Package ready:"
Write-Host "  File:    $zipPath"
Write-Host "  Version: $Version"
Write-Host "  SHA256:  $hash"
Write-Host "  Bytes:   $size"
Write-Host ""
Write-Host "Release tag: pehr-v$Version"
Write-Host "Upload asset: $zipName"
