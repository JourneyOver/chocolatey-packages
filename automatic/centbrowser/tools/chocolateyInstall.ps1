$ErrorActionPreference = 'Stop'
$pp = Get-PackageParameters

$packageName = 'CentBrowser'
$url = 'http://static.centbrowser.com/beta_32/centbrowser_3.8.5.52.exe'
$url64 = 'http://static.centbrowser.com/beta_64/centbrowser_3.8.5.52_x64.exe'
$checksum = 'a9e94f4a46bf3ad02cb8b0c8cac70937133bb8a2c0d5d058c0329b2dad9c57df'
$checksum64 = '5181f36adce836641f22950ff43390770d2df0edb33b6b9ebf695b45840fcec7'
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

Install-ChocolateyPackage @packageArgs
