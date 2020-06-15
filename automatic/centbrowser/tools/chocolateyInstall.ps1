$ErrorActionPreference = 'Stop'
$pp = Get-PackageParameters

$packageName = 'CentBrowser'
$url = 'http://static.centbrowser.com/installer_32/centbrowser_4.2.10.171.exe'
$url64 = 'http://static.centbrowser.com/installer_64/centbrowser_4.2.10.171_x64.exe'
$checksum = 'b97910967ca4cfd60cf266d86edc6b2ed20b2de9940a515e29cd6b3195146008'
$checksum64 = '9af156e4030e7192d5041bfcc8abd8fdc965ed2b85b6a376c45b18ffc1f5b6ce'
$checksumType = 'sha256'

if (!$pp['dir']) { $pp['dir'] = "$env:LOCALAPPDATA" }

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url
  url64Bit       = $url64
  silentArgs     = "--cb-auto-update --do-not-launch-chrome --cb-install-path=$($pp['dir'])"
  validExitCodes = @(0)
  checksum       = $checksum
  checksum64     = $checksum64
  checksumType   = $checksumType
  checksumType64 = $checksumType
}

if ($pp['NoDesktopIcon'] -eq 'true') { $packageArgs.silentArgs += " --do-not-create-desktop-shortcut" }
if ($pp['NoTaskbarIcon'] -eq 'true') { $packageArgs.silentArgs += " --do-not-create-taskbar-shortcut" }

Install-ChocolateyPackage @packageArgs
