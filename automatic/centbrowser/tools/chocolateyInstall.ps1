$ErrorActionPreference = 'Stop'
$pp = Get-PackageParameters

$packageName = 'CentBrowser'
$url = 'http://static.centbrowser.com/beta_32/centbrowser_4.3.9.182.exe'
$url64 = 'http://static.centbrowser.com/beta_64/centbrowser_4.3.9.182_x64.exe'
$checksum = 'a980cfe4061dbb85893efc265b23aff5aad362cb57a7514bef826bbd8a586838'
$checksum64 = '1efadf11c1ab06734e55bca6180d41d1ff067a7e25a4319b19c79049ccb354b1'
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
