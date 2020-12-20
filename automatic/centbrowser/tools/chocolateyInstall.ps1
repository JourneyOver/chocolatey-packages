$ErrorActionPreference = 'Stop'
$pp = Get-PackageParameters

$packageName = 'CentBrowser'
$url = 'http://static.centbrowser.com/win_stable/4.3.9.227/centbrowser_4.3.9.227.exe'
$url64 = 'http://static.centbrowser.com/win_stable/4.3.9.227/centbrowser_4.3.9.227_x64.exe'
$checksum = '25fdc24255fb106fe383e5f3adf9170e4f5558c8dfcea797e414281801f951d9'
$checksum64 = '769b833e20abc15d4a89d5535a16caa319ee481ad38d3f96a2564741cf6e012d'
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
