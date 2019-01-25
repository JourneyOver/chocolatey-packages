$ErrorActionPreference = 'Stop'

$packageName = 'gitahead'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$fileLocation = if ((Get-OSArchitectureWidth 64) -and $env:chocolateyForceX86 -ne 'true') {
  Write-Host "Using 64 bit version"; Get-Item "$toolsDir\GitAhead-win64-*"
} else { Write-Host "Using 32 bit version"; Get-Item "$toolsDir\GitAhead-win32-*" }

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  file           = $fileLocation
  silentArgs     = "/S"
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

# Remove the installers as there is no more need for it
Remove-Item $toolsDir\*.exe -ea 0 -Force
