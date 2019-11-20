$ErrorActionPreference = 'Stop'
$pp = Get-PackageParameters

$packageName = 'CentBrowser'
$url = 'http://static.centbrowser.com/beta_32/centbrowser_4.1.6.137.exe'
$url64 = 'http://static.centbrowser.com/beta_64/centbrowser_4.1.6.137_x64.exe'
$checksum = '63b507ff3898004cde9d888f3e982f705338069dc6dd8f3763c91fc26828c7a3'
$checksum64 = '9f92e5d7b88a0d7ab0d9a5268a0d90d8575563811dcaa370a9df43f87dcae60b'
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
