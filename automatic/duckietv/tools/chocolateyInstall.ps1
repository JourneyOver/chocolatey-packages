$ErrorActionPreference = 'Stop'

$packageName = 'duckietv'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$url32 = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-202209301924/DuckieTV-202209301924-windows-x32.zip'
$url64 = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-202209301924/DuckieTV-202209301924-windows-x64.zip'
$checksum32 = 'e4cda87c9b736147d60b2e480d5de678b1a1f5f1cda34cacd84809788ad3c47c'
$checksum64 = '58f82865a13b3051899d7830feaedea409830f814b3da5a273be20e7c1a2c457'
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
