$registry = Get-UninstallRegistryKey -SoftwareName 'Cent Browser'
$file = $registry.UninstallString
$Arg_chk = ($file -match "--system-level")
$chromiumArgs = @{$true = "--uninstall --system-level"; $false = "--uninstall"}[ $Arg_chk ]
$silentArgs = @{$true = '--uninstall --system-level --force-uninstall'; $false = '--uninstall --force-uninstall'}[ $Arg_chk ]
$myfile = $file -replace ( $chromiumArgs )

$packageName = 'CentBrowser'

$packageArgs = @{
  packageName    = $packageName
  FileType       = 'exe'
  SilentArgs     = $silentArgs
  validExitCodes = @(0, 19, 21)
  File           = $myfile
}

Uninstall-ChocolateyPackage @packageArgs
# Currently doesn't delete User Data folder