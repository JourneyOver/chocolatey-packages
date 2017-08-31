$packageName = 'duckietv'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32 = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-201708310130/DuckieTV-201708310130-windows-x32.zip'
$url64 = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-201708310130/DuckieTV-201708310130-windows-x64.zip'
$checksum32 = '13DC5FAD485EE2BA333A1BBA2B421E3E9C22754461E408D021C93BAC4B111242'
$checksum64 = 'F2638A35AA4C8917EB862A18F78BAAE8E7A0FACBE8B1F9D7B39C720A381A7E09'
$silentArgs = '/S'
$validExitCodes = @(0)
$bits = $ENV:PROCESSOR_ARCHITECTURE -replace ("amd", "") -replace ("x86", "32")
$fversion = $version.replace('.', '').replace('-nightly', '')
$fileLocation = "$env:ChocolateyInstall\lib\$packageName\tools\DuckieTV-$fversion-windows-x$bits.exe"

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

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $fileLocation
  silentArgs     = $silentArgs
  validExitCodes = $validExitCodes
  softwareName   = 'DuckieTV*'
}

Install-ChocolateyInstallPackage @packageArgs
