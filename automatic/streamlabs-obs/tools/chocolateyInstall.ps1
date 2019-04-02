$ErrorActionPreference = 'Stop'

$packageName = 'streamlabs-obs'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$fileLocation = Get-Item "$toolsDir\*.exe"

if ((Get-OSArchitectureWidth 32) -or $env:ChocolateyForceX86) {
  throw ("This application currently only supports 64-bit Windows.")
}

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  file           = $fileLocation
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

# Remove the installers as there is no more need for it
Remove-Item $toolsDir\*.exe -ea 0 -Force
