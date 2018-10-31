$ErrorActionPreference = 'Stop'
$pp = Get-PackageParametersBuiltIn

$packageName = 'CentBrowser'
$url = 'http://static.centbrowser.com/installer_32/centbrowser_3.6.8.99.exe'
$url64 = 'http://static.centbrowser.com/installer_64/centbrowser_3.6.8.99_x64.exe'
$checksum = '7998de5b8327f317f184cb46fbb5d49134fa9f88b3b3bba5bec5039398cbb132'
$checksum64 = '0cddcdfc824f1707f01aacf5079a45a53b97a99cf36b2f7c02b6b9da636e4b5e'
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
