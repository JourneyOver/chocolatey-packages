$ErrorActionPreference = 'Stop'

$packageName = 'bsplayer'
$programUninstallEntryName = "BS.Player"

$PATHS = @("HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall",
  "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall")

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  silentArgs     = "/S"
  validExitCodes = @(0)
}

# Kill BSplayer process before uninstall if running
$killBS = Get-Process bsplayer -ErrorAction SilentlyContinue
if ($killBS) {
  # try gracefully first
  $killBS.CloseMainWindow()
  # kill after ten seconds
  Start-Sleep 10
  if (!$killBS.HasExited) {
    $killBS | Stop-Process -Force
  }
}

ForEach ($path in $PATHS) {
  $installed = Get-ChildItem -Path $path |
    ForEach-Object { Get-ItemProperty $_.PSPath } |
    Where-Object { $_.DisplayName -match $programUninstallEntryName } |
    Select-Object -Property DisplayName, DisplayVersion, UninstallString, QuietUninstallString

  ForEach ($app in $installed) {
    $packageArgs['file'] = "$($app.UninstallString)"
    Uninstall-ChocolateyPackage @packageArgs
  }
}