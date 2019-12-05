$ErrorActionPreference = 'Stop'
$pp = Get-PackageParameters

$packageName = 'CentBrowser'
$url = 'http://static.centbrowser.com/beta_32/centbrowser_4.1.7.162.exe'
$url64 = 'http://static.centbrowser.com/beta_64/centbrowser_4.1.7.162_x64.exe'
$checksum = 'f6a5fc09cfed8ec6546da8ae8bd5625b79a8d88424caf900e232efffa504d2ac'
$checksum64 = '8bf6c2fdc1899e77554551915c6443f078d03e510630bc39b54d12d636baff0f'
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
