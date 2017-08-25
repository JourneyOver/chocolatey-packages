$ErrorActionPreference = 'Stop'

$programUninstallEntryName = "DuckieTV*"
$packageName = 'duckietv'

$uninstallString = (Get-ItemProperty HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*, HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*, HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, UninstallString | Where-Object {$_.DisplayName -like "$programUninstallEntryName*"}).UninstallString

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  silentArgs     = '/S'
  validExitCodes = @(0)
  File           = $uninstallString
}

Uninstall-ChocolateyPackage @packageArgs