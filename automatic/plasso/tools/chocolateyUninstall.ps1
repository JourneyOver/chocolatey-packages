$ErrorActionPreference = 'Stop'

$packageName = 'plasso'
$programUninstallEntryName = "Process Lasso"

$PATHS = @("HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall",
  "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall")

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  silentArgs     = "/S"
  validExitCodes = @(0, 3010, 1605, 1614, 1641)
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