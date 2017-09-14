$packageName = 'duckietv'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32 = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-201709140130/DuckieTV-201709140130-windows-x32.zip'
$url64 = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-201709140130/DuckieTV-201709140130-windows-x64.zip'
$checksum32 = '5970704919A97AFBE7D4EF676281AA82BDAB860B6FF75FD9140ED53914FE617B'
$checksum64 = 'E4770A27EC885EB0C2396C8AC42A572BFBFED6558917780D9897363EE8D399C9'
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
