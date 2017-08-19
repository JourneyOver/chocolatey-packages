$registry = Get-UninstallRegistryKey -SoftwareName 'Cent Browser'
$file = $registry.UninstallString
$Arg_chk = ($file -match "--system-level")
$chromiumArgs = @{$true = "--uninstall --system-level"; $false = "--uninstall"}[ $Arg_chk ]
$silentArgs = @{$true = '--uninstall --system-level --force-uninstall'; $false = '--uninstall --force-uninstall'}[ $Arg_chk ]
$myfile = $file -replace ( $chromiumArgs )

# All arguments for the Uninstallation of this package
$packageArgs = @{
  PackageName    = 'CentBrowser'
  FileType       = 'exe'
  SilentArgs     = $silentArgs
  validExitCodes = @(0, 19, 21)
  File           = $myfile
}

# Kill CB process before uninstall if running
$killCB = Get-Process chrome -ErrorAction SilentlyContinue
if ($killCB) {
  # try gracefully first
  $killCB.CloseMainWindow()
  # kill after ten seconds
  Start-Sleep 10
  if (!$killCB.HasExited) {
    $killCB | Stop-Process -Force
  }
}

# Now to Uninstall the Package
Uninstall-ChocolateyPackage @packageArgs
# Currently doesn't delete User Data folder