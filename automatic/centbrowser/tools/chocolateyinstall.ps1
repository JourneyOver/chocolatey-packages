$ErrorActionPreference = 'Stop'
$pp = Get-PackageParameters

$packageName = 'CentBrowser'
$url = 'http://static.centbrowser.com/installer_32/centbrowser_2.9.4.39.exe'
$url64 = 'http://static.centbrowser.com/installer_64/centbrowser_2.9.4.39_x64.exe'
$checksum = 'b60cf66a6256b3581efcf124c3bd27aaed6c53a9fc630a608dad74bac352a44c'
$checksum64 = '51ac462f961161109748cc477b53f02dd22532deb4ca5cc1958800d718a25b22'
$registrypaths = @('HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\CentBrowser', 'HKCU:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\CentBrowser')
$version = '2.9.4.39'

if (!$pp['dir']) { $pp['dir'] = "$env:LOCALAPPDATA" }

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url
  url64Bit       = $url64
  silentArgs     = "--cb-auto-update --cb-install-path=$($pp['dir'])"
  validExitCodes = @(0)
  checksum       = $checksum
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}

Foreach ($registry in $registrypaths) {
  if (Test-Path $registry) {
    $installedVersion = (
      Get-ItemProperty -Path $registry -Name 'DisplayVersion'
    ).DisplayVersion
  }
}

if ($installedVersion -eq $version) {
  Write-Output $(
    "Cent Browser $installedVersion is already installed. " +
    "Skipping download and installation."
  )
} else {
  Install-ChocolateyPackage @packageArgs
}
