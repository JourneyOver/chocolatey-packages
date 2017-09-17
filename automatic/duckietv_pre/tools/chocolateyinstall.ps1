$ErrorActionPreference = 'Stop'

$packageName = 'duckietv'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-201709170130/DuckieTV-201709170130-windows-x32.zip'
$url64 = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-201709170130/DuckieTV-201709170130-windows-x64.zip'
$checksum = '38E8269F2726E1E5E20A62559E349D61475520F20AE799E26FE67A633D1D0436'
$checksum64 = 'A8980CAD226A0408377C4686BEEFA7420D3ED410FC0C252A5E58C601BEE19B03'
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
