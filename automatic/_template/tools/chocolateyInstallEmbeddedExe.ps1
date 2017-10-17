$ErrorActionPreference = 'Stop'

$packageName = ''

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$fileLocation = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
  Write-Host "Installing 64 bit version"; Get-Item "$toolsDir\*_x64.exe"
} else { Write-Host "Installing 32 bit version"; Get-Item "$toolsDir\*_x32.exe" }

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  softwareName   = '*'
  file           = $fileLocation
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item $toolsDir\*.exe -ea 0 -force

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if ($installLocation) {
  Write-Host "$($packageArgs.packageName) installed to '$installLocation'"
  Register-Application "$installLocation\.exe"
} else {
  Write-Warning "Can't find $($packageArgs.packageName) install location"
}
