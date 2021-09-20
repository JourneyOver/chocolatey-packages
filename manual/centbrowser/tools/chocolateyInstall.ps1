$ErrorActionPreference = 'Stop'
$pp = Get-PackageParameters

$packageName = 'CentBrowser'
$url = 'http://static.centbrowser.com/win_stable/4.3.9.248/centbrowser_4.3.9.248.exe'
$url64 = 'http://static.centbrowser.com/win_stable/4.3.9.248/centbrowser_4.3.9.248_x64.exe'
$checksum = 'd4ccd541b86ef27cc790d5e0b96e0a2dc6eee079ca5dcd60919c7ca1b27e32dc'
$checksum64 = 'bb5acb580260074c7a16cb0416b1e872032bd6aebbf0ac97561eced58f66c119'
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
