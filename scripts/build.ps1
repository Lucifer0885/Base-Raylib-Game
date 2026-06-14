param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$RemainingArgs
)

$ErrorActionPreference = "Stop"

. "$PSScriptRoot\cmake-common.ps1"

$ProjectRoot = Split-Path -Parent $PSScriptRoot
$Config = Get-BuildConfig -RemainingArgs $RemainingArgs

Set-Location $ProjectRoot

if (Test-NeedsConfigure -ProjectRoot $ProjectRoot -Config $Config) {
    Invoke-CMakeConfigure -ProjectRoot $ProjectRoot -BuildType $Config
}

Initialize-VisualStudio
Write-Host "Building Aether ($Config)..." -ForegroundColor Cyan
cmake --build build
exit $LASTEXITCODE
