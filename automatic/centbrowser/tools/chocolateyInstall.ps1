$ErrorActionPreference = 'Stop'
$pp = Get-PackageParameters

$packageName = 'CentBrowser'
$url = 'http://static.centbrowser.com/installer_32/centbrowser_3.8.5.69.exe'
$url64 = 'http://static.centbrowser.com/installer_64/centbrowser_3.8.5.69_x64.exe'
$checksum = '542ad281f09b74d7909ae0f8a36c54607e8b2518943261542b07263a73856740'
$checksum64 = '9a8ebae825fe4ceff5fa6166417c33d6a930f657f15ea299912a348dcd78ff78'
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
