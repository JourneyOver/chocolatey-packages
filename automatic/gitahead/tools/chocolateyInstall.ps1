$ErrorActionPreference = 'Stop'

$packageName = 'gitahead'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$fileLocation = Get-Item "$toolsDir\GitAhead-win32-*"
$fileLocation64 = Get-Item "$toolsDir\GitAhead-win64-*"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  file           = $fileLocation
  file64         = $fileLocation64
  silentArgs     = "/S"
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

# Remove the installers as there is no more need for it
Remove-Item $toolsDir\*.exe -ea 0 -Force
