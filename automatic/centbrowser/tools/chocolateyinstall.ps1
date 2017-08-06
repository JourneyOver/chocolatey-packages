$ErrorActionPreference = 'Stop'

$packageName = 'centbrowser'
$url32 = 'http://static.centbrowser.com/installer_32/centbrowser_2.7.4.52.exe'
$url64 = 'http://static.centbrowser.com/installer_64/centbrowser_2.7.4.52_x64.exe'
$checksum32 = '1675f67e2c2219b7a750441538ab7782daf07688fb02dad85500d7a8faa91cbc'
$checksum64 = 'f8651427d568ca334089cd2a5d046b63228419f018039a1564a5377248548d43'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url32
  url64Bit       = $url64
  silentArgs     = "--cb-auto-update"
  validExitCodes = @(0)
  checksum       = $checksum32
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}

Install-ChocolateyPackage @packageArgs
