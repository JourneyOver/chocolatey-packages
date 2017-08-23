$ErrorActionPreference = 'Stop'

$packageName = 'CentBrowser'
$url32 = 'http://static.centbrowser.com/installer_32/centbrowser_2.8.3.58.exe'
$url64 = 'http://static.centbrowser.com/installer_64/centbrowser_2.8.3.58_x64.exe'
$checksum32 = 'c30e842d3b64fc9b67e7b44e00eec724d5974dad4003d7007621d5c011bf754e'
$checksum64 = 'e9b42feb0f4f5ca47b8f8f7135f696dc0380f97718191822d473d41b6d2a56e4'

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