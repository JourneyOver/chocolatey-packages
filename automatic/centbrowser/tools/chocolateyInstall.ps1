$ErrorActionPreference = 'Stop'
$pp = Get-PackageParametersBuiltIn

$packageName = 'CentBrowser'
$url = 'http://static.centbrowser.com/installer_32/centbrowser_3.4.3.38.exe'
$url64 = 'http://static.centbrowser.com/installer_64/centbrowser_3.4.3.38_x64.exe'
$checksum = '9c1dedfb2ebf48e20e8b67076033db89162a6a991ba9260bd095d46a516e5742'
$checksum64 = '5efb066d61fade7237fe824b2e169bed3f149ba27a3fba9a733507920c24baea'
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
