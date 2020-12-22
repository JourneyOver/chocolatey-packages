$ErrorActionPreference = 'Stop'
$pp = Get-PackageParameters

$packageName = 'CentBrowser'
$url = 'http://static.centbrowser.com/win_stable/4.3.9.238/centbrowser_4.3.9.238.exe'
$url64 = 'http://static.centbrowser.com/win_stable/4.3.9.238/centbrowser_4.3.9.238_x64.exe'
$checksum = 'a56e05324bed5eabbe430958df680d6eda041acad46c13b1f772e00548ee2705'
$checksum64 = 'd71b20011e36590ffeb3f6658ebe8e100f7e29c6c7d4616ff55bfb87777e08e0'
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
