$ErrorActionPreference = 'Stop'

$packageName = 'streamlabs-obs'
$url64 = 'https://slobs-cdn.streamlabs.com/Streamlabs+OBS+Setup+0.13.3.exe'
$checksum64 = '3d3ccdb02008b8e32f1b36d871b0ceb67a8f6943f41becaefeb1783e512c0242'
$checksumType = 'sha256'

if ((Get-OSArchitectureWidth 32) -or $env:ChocolateyForceX86) {
  throw ("This application currently only supports 64-bit Windows.")
}

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64          = $url64
  silentArgs     = "/S"
  validExitCodes = @(0)
  checksum64     = $checksum64
  checksumType   = $checksumType
}

Install-ChocolateyPackage @packageArgs
