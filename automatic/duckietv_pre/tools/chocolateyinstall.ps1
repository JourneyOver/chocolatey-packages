$ErrorActionPreference = 'Stop'

$packageName = 'duckietv'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-201709270130/DuckieTV-201709270130-windows-x32.zip'
$url64 = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-201709270130/DuckieTV-201709270130-windows-x64.zip'
$checksum = 'b5bf37b419d6ac9cfb00788c620b9ed9574ffb551b5d2cae7f8dbf0e18cda419'
$checksum64 = 'd68b03f42a728fe61b30e8e1f5758fa1826055e7cf4c266d008f75ba80585835'
$silentArgs = '/S'
$validExitCodes = @(0)
$bits = Get-ProcessorBits
$fversion = $env:ChocolateyPackageVersion.replace('.', '').replace('-nightly', '')
$fileLocation = "$env:ChocolateyInstall\lib\$packageName\tools\DuckieTV-$fversion-windows-x$bits.exe"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'ZIP'
  url            = $url
  url64Bit       = $url64
  unzipLocation  = $toolsDir
  checksum       = $checksum
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $fileLocation
  silentArgs     = $silentArgs
  validExitCodes = $validExitCodes
  softwareName   = 'DuckieTV*'
}

Install-ChocolateyInstallPackage @packageArgs
