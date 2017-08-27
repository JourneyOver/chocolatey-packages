$packageName = 'duckietv'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32 = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-201708270130/DuckieTV-201708270130-windows-x32.zip'
$url64 = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-201708270130/DuckieTV-201708270130-windows-x64.zip'
$checksum32 = '5E2ACFB14BAFC0A85EB3F84CE604FBC2D91CFDF6AFA586AB8CA25EAE723ECE8C'
$checksum64 = 'E4196AB7DA3348EC6FDA454736C9FC954F9DFE9A5E7745FECFC726004B889F99'
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
