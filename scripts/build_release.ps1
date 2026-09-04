# =============================================================================
# ElectroApp -- build_release.ps1
# Verifica (analyze + test), incrementeaza BUILD-ul din pubspec.yaml si
# construieste APK-ul release semnat cu android/key.properties.
#
#   .\scripts\build_release.ps1              # bump BUILD + APK arm64
#   .\scripts\build_release.ps1 -NoBump      # fara incrementare
#   .\scripts\build_release.ps1 -AllAbi      # APK universal (toate ABI-urile)
#   .\scripts\build_release.ps1 -Bundle      # si App Bundle (.aab) pentru Play
#   .\scripts\build_release.ps1 -SkipChecks  # fara analyze/test
# =============================================================================
param(
    [switch]$NoBump,
    [switch]$AllAbi,
    [switch]$Bundle,
    [switch]$SkipChecks
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = Split-Path -Parent $PSScriptRoot
Set-Location $ProjectRoot

if (-not (Test-Path 'android\key.properties')) {
    Write-Host 'Lipseste android/key.properties - release-ul nu se poate semna.' -ForegroundColor Red
    exit 1
}

# -- Versiune ------------------------------------------------------------------
$pubspec = Get-Content 'pubspec.yaml' -Raw -Encoding utf8
if ($pubspec -notmatch '(?m)^version:\s*(\d+)\.(\d+)\.(\d+)\+(\d+)') {
    Write-Host 'Nu gasesc "version: X.Y.Z+B" in pubspec.yaml' -ForegroundColor Red
    exit 1
}
$major = [int]$Matches[1]; $minor = [int]$Matches[2]; $patch = [int]$Matches[3]; $build = [int]$Matches[4]
if (-not $NoBump) {
    $build++
    $pubspec = $pubspec -replace '(?m)^version:\s*\d+\.\d+\.\d+\+\d+', "version: $major.$minor.$patch+$build"
    [IO.File]::WriteAllText((Join-Path $ProjectRoot 'pubspec.yaml'), $pubspec, (New-Object Text.UTF8Encoding $false))
}
$tag = "v$major.$minor.$build"
Write-Host "Versiune: $major.$minor.$patch+$build  (tag $tag)" -ForegroundColor Cyan

# -- Verificari ----------------------------------------------------------------
if (-not $SkipChecks) {
    flutter analyze; if ($LASTEXITCODE -ne 0) { exit 1 }
    flutter test;    if ($LASTEXITCODE -ne 0) { exit 1 }
}

# -- Build ---------------------------------------------------------------------
New-Item -ItemType Directory -Force 'symbols\android' | Out-Null
$args = @('build', 'apk', '--release', '--obfuscate', '--split-debug-info=symbols/android/')
if (-not $AllAbi) { $args += @('--target-platform', 'android-arm64') }
flutter @args; if ($LASTEXITCODE -ne 0) { exit 1 }

$out = 'build\app\outputs\flutter-apk'
$apk = Join-Path $out "ElectroApp-$tag.apk"
Copy-Item (Join-Path $out 'app-release.apk') $apk -Force
Write-Host "APK: $apk" -ForegroundColor Green

if ($Bundle) {
    flutter build appbundle --release --obfuscate --split-debug-info=symbols/android/
    if ($LASTEXITCODE -ne 0) { exit 1 }
    Write-Host 'AAB: build\app\outputs\bundle\release\app-release.aab' -ForegroundColor Green
}

Write-Host ''
Write-Host "Urmatorul pas: actualizeaza CHANGELOG.md si README.md, apoi:" -ForegroundColor Yellow
Write-Host "  git add -A; git commit -m 'release: $tag'; git tag $tag; git push; git push origin $tag"
