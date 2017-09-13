$ErrorActionPreference = 'Stop'

$packageName = 'CentBrowser'
$programUninstallEntryName = 'Cent Browser*'

$registry = Get-UninstallRegistryKey -SoftwareName $programUninstallEntryName
$file = $registry.UninstallString
$Arg_chk = ($file -match "--system-level")
$chromiumArgs = @{$true = "--uninstall --system-level"; $false = "--uninstall"}[ $Arg_chk ]
$silentArgs = @{$true = '--uninstall --system-level --cb-silent-uninstall-type=0'; $false = '--uninstall --cb-silent-uninstall-type=0'}[ $Arg_chk ]
$myfile = $file -replace ( $chromiumArgs )

$packageArgs = @{
  packageName    = $packageName
  FileType       = 'exe'
  SilentArgs     = $silentArgs
  validExitCodes = @(0, 19, 21)
  File           = $myfile
}

Uninstall-ChocolateyPackage @packageArgs
# Currently doesn't delete User Data folder