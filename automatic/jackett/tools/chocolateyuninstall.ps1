$ErrorActionPreference = 'Stop'

$packageName = 'jackett'
$programUninstallEntryName = "Jackett*"

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

#remove Jackett folder that gets left behind
$fexist = Test-Path $env:ProgramData\Jackett
If ($fexist) {
  Write-Host "Removing Jackett Folder that's left behind"
  Remove-Item $env:ProgramData\Jackett -Recurse -Force
} else {
  Write-Host Jackett Folder not found
}