$ErrorActionPreference = 'Stop'

$packageName = 'duckietv'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-201709240130/DuckieTV-201709240130-windows-x32.zip'
$url64 = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-201709240130/DuckieTV-201709240130-windows-x64.zip'
$checksum = 'e988c150dfcb42d955f3a4cefe38a3f6ffd08feafd68ce2677f38ac78a677ca0'
$checksum64 = 'f73f47b3a67d2a6d4566afbc0fc861c8ec09a993bdf4ddb19947ec623af523f9'
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
