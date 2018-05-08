$ErrorActionPreference = 'Stop'
$pp = Get-PackageParametersBuiltIn

$packageName = 'CentBrowser'
$programUninstallEntryName = 'Cent Browser*'

if (!$pp['del_userdata']) { $pp['del_userdata'] = "0" }

$registry = Get-UninstallRegistryKey -SoftwareName $programUninstallEntryName
$file = $registry.UninstallString
$Arg_chk = ($file -match "--system-level")
$chromiumArgs = @{ $true = "--uninstall --system-level"; $false = "--uninstall" }[$Arg_chk]
$silentArgs = @{ $true = "--uninstall --system-level --cb-silent-uninstall-type=$($pp['del_userdata'])"; $false = "--uninstall --cb-silent-uninstall-type=$($pp['del_userdata'])" }[$Arg_chk]
$myfile = $file -replace ($chromiumArgs)

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  silentArgs     = $silentArgs
  validExitCodes = @(0, 19, 21)
  file           = $myfile
}

Uninstall-ChocolateyPackage @packageArgs
