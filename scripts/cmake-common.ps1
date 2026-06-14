function Get-BuildConfig {
    param(
        [string[]]$RemainingArgs
    )

    if ($RemainingArgs -contains "--release") { "Release" } else { "Debug" }
}

function Initialize-VisualStudio {
    $vswhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
    if (-not (Test-Path $vswhere)) {
        throw "vswhere.exe not found. Install Visual Studio with C++ build tools."
    }

    $vsPath = & $vswhere -latest -property installationPath
    if (-not $vsPath) {
        throw "Visual Studio installation not found."
    }

    $vcvars = Join-Path $vsPath "VC\Auxiliary\Build\vcvars64.bat"
    if (-not (Test-Path $vcvars)) {
        throw "vcvars64.bat not found at '$vcvars'."
    }

    cmd /c "`"$vcvars`" >nul 2>&1 && set" | ForEach-Object {
        if ($_ -match '^(?<key>[^=]+)=(?<val>.*)$') {
            Set-Item -Path "env:$($Matches.key)" -Value $Matches.val
        }
    }
}

function Test-NeedsConfigure {
    param(
        [string]$ProjectRoot,
        [string]$Config
    )

    $cacheFile = Join-Path $ProjectRoot "build\CMakeCache.txt"
    if (-not (Test-Path $cacheFile)) {
        return $true
    }

    $cache = Get-Content $cacheFile -Raw
    if ($cache -notmatch 'CMAKE_GENERATOR:INTERNAL=Ninja') {
        return $true
    }

    if ($cache -notmatch "CMAKE_BUILD_TYPE:STRING=$([regex]::Escape($Config))") {
        return $true
    }

    return $false
}

function Invoke-CMakeConfigure {
    param(
        [string]$ProjectRoot,
        [string]$BuildType
    )

    Initialize-VisualStudio
    Set-Location $ProjectRoot

    Write-Host "Configuring CMake ($BuildType)..." -ForegroundColor Cyan
    cmake -S . -B build -G Ninja "-DCMAKE_BUILD_TYPE=$BuildType"
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
}
