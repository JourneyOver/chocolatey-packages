$ErrorActionPreference = 'Stop'
$pp = Get-PackageParameters

$packageName = 'CentBrowser'
$url = 'http://static.centbrowser.com/installer_32/centbrowser_3.1.5.52.exe'
$url64 = 'http://static.centbrowser.com/installer_64/centbrowser_3.1.5.52_x64.exe'
$checksum = 'a1bde6cee0d802592188c76b6feea16741076dbb3cdbb28986b72a046fa01478'
$checksum64 = '3eb8e52237d82d14d0abc8f34f0ebb2d1366c41c228299b7cb75dc1e167318ac'
$checksumType = 'sha256'

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
  checksumType   = $checksumType
  checksumType64 = $checksumType
}

if ($pp['NoDesktopIcon'] -eq 'true') { $packageArgs.silentArgs += " --do-not-create-desktop-shortcut" }
if ($pp['NoTaskbarIcon'] -eq 'true') { $packageArgs.silentArgs += " --do-not-create-taskbar-shortcut" }
if ($pp['NoStartmenuIcon'] -eq 'true') { $packageArgs.silentArgs += " --do-not-create-startmenu-shortcut" }

Install-ChocolateyPackage @packageArgs
