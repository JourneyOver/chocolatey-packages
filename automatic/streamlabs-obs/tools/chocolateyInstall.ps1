$ErrorActionPreference = 'Stop'

$packageName = 'streamlabs-obs'
$url64 = 'https://slobs-cdn.streamlabs.com/Streamlabs+Desktop+Setup+1.13.2.exe'
$checksum64 = '13e5be2ecde263aecda6686b9a88da18abc28eda00c4b99671ef273bf4bb4f8b'
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
