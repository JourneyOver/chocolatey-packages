$ErrorActionPreference = 'Stop'

$packageName = 'tsedat'
$programUninstallEntryName = 'TheSage*'

$registry = Get-UninstallRegistryKey -SoftwareName $programUninstallEntryName
$file = $registry.UninstallString

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  silentArgs     = '/S'
  validExitCodes = @(0)
  file           = $file
}

Uninstall-ChocolateyPackage @packageArgs

#remove TheSage folder that gets left behind
$fexist = Test-Path "${env:LOCALAPPDATA}\TheSage"
if ($fexist) {
  Write-Host "Removing TheSage Folder that's left behind"
  Start-Sleep -Seconds 5
  Remove-Item "${env:LOCALAPPDATA}\TheSage" -Recurse -Force
} else {
  Write-Host "TheSage Folder not found"
}
