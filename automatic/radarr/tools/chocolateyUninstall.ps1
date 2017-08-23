$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'radarr'
  fileType       = 'exe'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
  File           = "$env:ProgramData\Radarr\bin\unins000.exe"
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