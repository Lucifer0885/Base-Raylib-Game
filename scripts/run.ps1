param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$RemainingArgs
)

$ErrorActionPreference = "Stop"

. "$PSScriptRoot\cmake-common.ps1"

$ProjectRoot = Split-Path -Parent $PSScriptRoot
$Config = Get-BuildConfig -RemainingArgs $RemainingArgs
$ExePath = Join-Path $ProjectRoot "build\Aether.exe"

if (-not (Test-Path $ExePath)) {
    Write-Error "Executable not found at '$ExePath'. Run .\scripts\build.ps1 first."
    exit 1
}

if (Test-NeedsConfigure -ProjectRoot $ProjectRoot -Config $Config) {
    Write-Error "Build type mismatch. Run .\scripts\build.ps1$(if ($Config -eq 'Release') { ' --release' }) first."
    exit 1
}

Write-Host "Running Aether ($Config)..." -ForegroundColor Cyan
& $ExePath
exit $LASTEXITCODE
