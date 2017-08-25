$packageName = 'duckietv'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32 = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-201708250130/DuckieTV-201708250130-windows-x32.zip'
$url64 = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-201708250130/DuckieTV-201708250130-windows-x64.zip'
$checksum32 = 'AC6970F56CCDB86E62155084D98313E17CF2E22A3492E50C76FD13C2724E799D'
$checksum64 = '569F00AB7C73DED01006EEC494139E69F456B1C366DEF6212A5B7CA85FFEE13C'
$silentArgs = '/S'
$validExitCodes = @(0)
$bits = $ENV:PROCESSOR_ARCHITECTURE -replace ("amd","") -replace ("x86","32")
$fversion = $version.replace('.','').replace('-nightly','')
$fileLocation = "$env:ChocolateyInstall\lib\$packageName\tools\DuckieTV-$fversion-windows-x$bits.exe"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP'
  url           = $url32
  url64Bit      = $url64
  checksum      = $checksum32
  checksum64    = $checksum64
  checksumType  = 'sha256'
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