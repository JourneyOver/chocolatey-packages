$ErrorActionPreference = 'Stop'

$programUninstallEntryName = "DuckieTV"
$packageName = 'duckietv'

$PATHS = @("HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall",
  "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall")

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

ForEach ($path in $PATHS) {
  $installed = Get-ChildItem -Path $path |
    ForEach-Object { Get-ItemProperty $_.PSPath } |
    Where-Object { $_.DisplayName -match $programUninstallEntryName } |
    Select-Object -Property DisplayName, DisplayVersion, UninstallString

  ForEach ($app in $installed) {
    $packageArgs['file'] = "$($app.UninstallString)"
    Uninstall-ChocolateyPackage @packageArgs
  }
}