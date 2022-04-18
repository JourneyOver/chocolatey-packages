$ErrorActionPreference = 'Stop'

$packageName = 'loot'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$fileLocation32bit = Get-Item "$toolsDir\*win32.exe"
$fileLocation64bit = Get-Item "$toolsDir\*win64.exe"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  file           = $fileLocation
  file64         = $fileLocation64bit
  silentArgs     = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoInstall.log`""
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

# Remove the installers as there is no more need for it
Remove-Item $toolsDir\*.exe -ea 0 -Force
