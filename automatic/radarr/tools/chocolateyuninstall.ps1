$ErrorActionPreference = 'Stop'

$packageName = 'radarr'
$programUninstallEntryName = 'Radarr*'

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

#remove Radarr folder that gets left behind
$fexist = Test-Path $env:ProgramData\Radarr
If ($fexist) {
  Write-Host "Removing Radarr Folder that's left behind"
  Remove-Item $env:ProgramData\Radarr -Recurse -Force
} else {
  Write-Host Radarr Folder not found
}
