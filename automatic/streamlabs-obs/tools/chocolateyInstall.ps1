$ErrorActionPreference = 'Stop'

$packageName = 'streamlabs-obs'
$url64 = 'https://slobs-cdn.streamlabs.com/Streamlabs+Desktop+Setup+1.13.1.exe'
$checksum64 = 'daa4acb3ae7a2f1a724892eb3739d65e42e5b94d3e53ae176c6fd03348003763'
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
