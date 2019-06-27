$ErrorActionPreference = 'Stop'

$packageName = 'sonarr'
$programUninstallEntryName = 'Sonarr*'

$registry = Get-UninstallRegistryKey -SoftwareName $programUninstallEntryName
$file = $registry.UninstallString

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
  file           = $file
}

Uninstall-ChocolateyPackage @packageArgs

#remove Sonarr folder that gets left behind
$fexist = Test-Path "${env:ProgramData}\NzbDrone"
if ($fexist) {
  Write-Host "Removing Sonarr Folder that's left behind"
  Remove-Item "${env:ProgramData}\NzbDrone" -Recurse -Force
} else {
  Write-Host "Sonarr Folder not found"
}
