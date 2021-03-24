$ErrorActionPreference = 'Stop'

$packageName = 'streamlabs-obs'
$url64 = 'https://slobs-cdn.streamlabs.com/Streamlabs+OBS+Setup+1.0.7.exe'
$checksum64 = '7b27874b113289dd02fe0eb8facfccff8c61f8a613da6c37cd5ae162399bb4f5'
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
