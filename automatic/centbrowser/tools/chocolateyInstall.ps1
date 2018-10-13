$ErrorActionPreference = 'Stop'
$pp = Get-PackageParametersBuiltIn

$packageName = 'CentBrowser'
$url = 'http://static.centbrowser.com/beta_32/centbrowser_3.6.8.58.exe'
$url64 = 'http://static.centbrowser.com/beta_64/centbrowser_3.6.8.58_x64.exe'
$checksum = 'a6fd92982ec00db4a5fd1375ef930ac3036ca1b05c304d42456f7c422ce686fd'
$checksum64 = '50f547ff39e6375e70597c10085ebb01291e1c7645b9f4ebb6e04ee1953a9161'
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
