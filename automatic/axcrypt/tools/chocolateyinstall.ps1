$ErrorActionPreference = 'Stop'

$packageName = 'axcrypt'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$fileLocation = Get-Item "$toolsDir\*.exe"

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
