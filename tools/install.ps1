[CmdletBinding()]
param(
    [string]$GameDir
)

$ErrorActionPreference = "Stop"

function Get-SteamLibraryRoots {
    $roots = New-Object System.Collections.Generic.List[string]
    $regPaths = @(
        "HKCU:\Software\Valve\Steam",
        "HKLM:\SOFTWARE\WOW6432Node\Valve\Steam",
        "HKLM:\SOFTWARE\Valve\Steam"
    )

    foreach ($regPath in $regPaths) {
        try {
            $steamPath = (Get-ItemProperty -Path $regPath -ErrorAction Stop).SteamPath
            if ($steamPath -and (Test-Path -LiteralPath $steamPath)) {
                $roots.Add($steamPath)
            }
        } catch {
        }
    }

    foreach ($root in @($roots)) {
        $libraryFile = Join-Path $root "steamapps\libraryfolders.vdf"
        if (-not (Test-Path -LiteralPath $libraryFile)) {
            continue
        }

        $content = Get-Content -LiteralPath $libraryFile -Raw
        foreach ($match in [regex]::Matches($content, '"path"\s+"([^"]+)"')) {
            $path = $match.Groups[1].Value -replace "\\\\", "\"
            if ($path -and (Test-Path -LiteralPath $path)) {
                $roots.Add($path)
            }
        }
    }

    $roots | Select-Object -Unique
}

function Find-GameDir {
    param([string]$Preferred)

    if ($Preferred) {
        $resolved = Resolve-Path -LiteralPath $Preferred -ErrorAction SilentlyContinue
        if ($resolved -and (Test-Path -LiteralPath (Join-Path $resolved.Path "tanetsumi.exe"))) {
            return $resolved.Path
        }
        throw "The specified folder does not look like the game folder. tanetsumi.exe was not found: $Preferred"
    }

    foreach ($root in Get-SteamLibraryRoots) {
        $candidate = Join-Path $root "steamapps\common\Tanetsumi_no_uta"
        if (Test-Path -LiteralPath (Join-Path $candidate "tanetsumi.exe")) {
            return $candidate
        }
    }

    $manual = Read-Host "Game folder was not found automatically. Paste the folder that contains tanetsumi.exe"
    if (-not $manual) {
        throw "No game folder was provided. Installation cancelled."
    }
    return Find-GameDir -Preferred $manual
}

$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$packageRoot = Split-Path -Parent $scriptRoot
$patchFile = Join-Path $packageRoot "dist\tanetsumi.pfs.099"

if (-not (Test-Path -LiteralPath $patchFile)) {
    throw "Patch file was not found: $patchFile"
}

$gamePath = Find-GameDir -Preferred $GameDir
$target = Join-Path $gamePath "tanetsumi.pfs.099"

$sourceHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $patchFile).Hash

if (Test-Path -LiteralPath $target) {
    $targetHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $target).Hash
    if ($targetHash -eq $sourceHash) {
        Write-Host "Patch is already installed."
        exit 0
    }

    $stamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $backup = Join-Path $gamePath "tanetsumi.pfs.099.backup-$stamp"
    Copy-Item -LiteralPath $target -Destination $backup -Force
    Write-Host "Existing tanetsumi.pfs.099 was backed up to: $backup"
}

Copy-Item -LiteralPath $patchFile -Destination $target -Force
Write-Host "Installed: $target"
Write-Host "Please restart the game."
