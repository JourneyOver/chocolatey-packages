$ErrorActionPreference = 'Stop'

$packageName = 'duckietv'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$embedded_path = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
  Write-Host "Installing 64 bit version"; Get-Item "$toolsDir\*-x64.zip"
} else { Write-Host "Installing 32 bit version"; Get-Item "$toolsDir\*-x32.zip" }

$packageArgs = @{
  packageName  = $packageName
  FileFullPath = $embedded_path
  Destination  = $toolsDir
}

Get-ChocolateyUnzip @packageArgs

$fileLocation = Get-Item "$toolsDir\*.exe"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  softwareName   = 'DuckieTV*'
  file           = $fileLocation
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item $toolsDir\*.zip -ea 0 -Force
Remove-Item $toolsDir\*.exe -ea 0 -Force

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if ($installLocation) {
  Write-Host "$($packageArgs.packageName) installed to '$installLocation'"
  Register-Application "$installLocation\DuckieTV.exe"
  Register-Application "$installLocation\DuckieTV.exe" "DTV"
} else {
  Write-Warning "Can't find $($packageArgs.packageName) install location"
}
