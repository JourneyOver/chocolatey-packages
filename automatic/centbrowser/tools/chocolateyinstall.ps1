$ErrorActionPreference = 'Stop'

$packageName = 'CentBrowser'
$url32 = 'http://static.centbrowser.com/installer_32/centbrowser_2.8.5.75.exe'
$url64 = 'http://static.centbrowser.com/installer_64/centbrowser_2.8.5.75_x64.exe'
$checksum32 = '61321d3f95d6f7fa32953402aea9356772ff182d6011d687562c8f1b68c81884'
$checksum64 = 'd40aab989927f9958ba5188517d7d22ac3f6cd66c307670446a049884e1262b4'
$registryPath = $('HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\CentBrowser')
$version = '2.8.5.75'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url32
  url64Bit       = $url64
  silentArgs     = '--cb-auto-update'
  validExitCodes = @(0)
  checksum       = $checksum32
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}

if (Test-Path $registryPath) {
  $installedVersion = (
    Get-ItemProperty -Path $registryPath -Name 'DisplayVersion'
  ).DisplayVersion
}

if ($installedVersion -eq $version) {
  Write-Output $(
    "Cent Browser $installedVersion is already installed. " +
    "Skipping download and installation."
  )
} else {
  Install-ChocolateyPackage @packageArgs
}