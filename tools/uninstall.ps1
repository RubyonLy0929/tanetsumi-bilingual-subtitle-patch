[CmdletBinding()]
param(
    [string]$GameDir,
    [switch]$RestoreBackup
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
        throw "No game folder was provided. Uninstall cancelled."
    }
    return Find-GameDir -Preferred $manual
}

$gamePath = Find-GameDir -Preferred $GameDir
$target = Join-Path $gamePath "tanetsumi.pfs.099"

if (Test-Path -LiteralPath $target) {
    Remove-Item -LiteralPath $target -Force
    Write-Host "Removed patch file: $target"
} else {
    Write-Host "tanetsumi.pfs.099 was not found. The patch may already be uninstalled."
}

if ($RestoreBackup) {
    $backup = Get-ChildItem -LiteralPath $gamePath -Filter "tanetsumi.pfs.099.backup-*" -File |
        Sort-Object LastWriteTime -Descending |
        Select-Object -First 1

    if ($backup) {
        Copy-Item -LiteralPath $backup.FullName -Destination $target -Force
        Write-Host "Restored backup: $($backup.FullName)"
    } else {
        Write-Host "No backup file was found."
    }
}

Write-Host "Please restart the game."
