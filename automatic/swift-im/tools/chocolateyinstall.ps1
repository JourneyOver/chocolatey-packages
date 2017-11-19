$ErrorActionPreference = 'Stop'

$packageName = 'swift-im'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$fileLocation = Get-Item "$toolsDir\*.msi"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'msi'
  file           = $fileLocation
  silentArgs     = '/quiet /qn /norestart'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs

# Remove the installers as there is no more need for it
Remove-Item $toolsDir\*.msi -ea 0 -Force
