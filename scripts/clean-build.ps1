param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$RemainingArgs
)

$ErrorActionPreference = "Stop"

. "$PSScriptRoot\cmake-common.ps1"

$ProjectRoot = Split-Path -Parent $PSScriptRoot
$BuildDir = Join-Path $ProjectRoot "build"
$Config = Get-BuildConfig -RemainingArgs $RemainingArgs

Set-Location $ProjectRoot

if (Test-Path $BuildDir) {
    Write-Host "Removing build directory..." -ForegroundColor Cyan
    Remove-Item -Recurse -Force $BuildDir
}

Invoke-CMakeConfigure -ProjectRoot $ProjectRoot -BuildType $Config

Initialize-VisualStudio
Write-Host "Building Aether ($Config)..." -ForegroundColor Cyan
cmake --build build
exit $LASTEXITCODE
