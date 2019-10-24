$ErrorActionPreference = 'Stop'

$packageName = 'duckietv'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$url32 = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-201910240130/DuckieTV-201910240130-windows-x32.zip'
$url64 = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-201910240130/DuckieTV-201910240130-windows-x64.zip'
$checksum32 = 'b758ba8268c5415c683e3d6c55411d3d7d4b0814592af3c627ece9a2a0459186'
$checksum64 = 'b8cb47164e4201eaaf00d08da5b0c3cbd30d7b47248662a989b8b4fb55dfab34'
$silentArgs = '/S'
$validExitCodes = @(0)

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP'
  url            = $url32
  url64Bit       = $url64
  checksum       = $checksum32
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$fileLocation = Get-Item "$toolsDir\*.exe"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $fileLocation
  silentArgs     = $silentArgs
  validExitCodes = $validExitCodes
  softwareName   = 'DuckieTV*'
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item $toolsDir\*.zip -ea 0 -Force
Remove-Item $toolsDir\*.exe -ea 0 -Force
