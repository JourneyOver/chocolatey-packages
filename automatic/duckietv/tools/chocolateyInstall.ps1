$ErrorActionPreference = 'Stop'

$packageName = 'duckietv'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$url32 = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-201904110130/DuckieTV-201904110130-windows-x32.zip'
$url64 = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-201904110130/DuckieTV-201904110130-windows-x64.zip'
$checksum32 = '51ccf8e62dbb984fb726bd8c1856086852bf48143f1d12d852e197e328744247'
$checksum64 = 'ae8194b3fe405351ed620489f3af88b9642c6300bd85255e8a0fcdb82923b008'
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
