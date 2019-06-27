$ErrorActionPreference = 'Stop'

$packageName = 'lidarr'
$programUninstallEntryName = 'Lidarr*'

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

#remove Lidarr folder that gets left behind
$fexist = Test-Path "${env:ProgramData}\Lidarr"
if ($fexist) {
  Write-Host "Removing Lidarr Folder that's left behind"
  Remove-Item "${env:ProgramData}\Lidarr" -Recurse -Force
} else {
  Write-Host "Lidarr Folder not found"
}
