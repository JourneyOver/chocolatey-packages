$ErrorActionPreference = 'Stop'

$packageName = 'streamlabs-obs'
$url64 = 'https://slobs-cdn.streamlabs.com/Streamlabs+OBS+Setup+0.13.1.exe'
$checksum64 = '8dbb6b9f7bb5808ee3a1cf30f6c6a3ce5923c2167ce2579d1fef709836cc8c06'
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
