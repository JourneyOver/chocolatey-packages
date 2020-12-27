$ErrorActionPreference = 'Stop'
$pp = Get-PackageParameters

$packageName = 'CentBrowser'
$url = 'http://static.centbrowser.com/win_stable/4.3.9.241/centbrowser_4.3.9.241.exe'
$url64 = 'http://static.centbrowser.com/win_stable/4.3.9.241/centbrowser_4.3.9.241_x64.exe'
$checksum = '5f933d1d03e6c73e049794bd8eda33b5acf467c8b080d415dcbb67c0972ebc6a'
$checksum64 = '921ce4093e921e0558e39883c536f55157a7dcbe4160d51962b6677f64e4ccd2'
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
