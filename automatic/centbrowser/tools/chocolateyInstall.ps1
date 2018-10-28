$ErrorActionPreference = 'Stop'
$pp = Get-PackageParametersBuiltIn

$packageName = 'CentBrowser'
$url = 'http://static.centbrowser.com/installer_32/centbrowser_3.6.8.96.exe'
$url64 = 'http://static.centbrowser.com/installer_64/centbrowser_3.6.8.96_x64.exe'
$checksum = '655ad26403544be86ea5aaedf8c27405737042043e4b8bd4a953860239fd667d'
$checksum64 = 'd52357b5ff63361b90a490db64d36496338ec211cd8af9de14c9ae8fbb64a42d'
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
