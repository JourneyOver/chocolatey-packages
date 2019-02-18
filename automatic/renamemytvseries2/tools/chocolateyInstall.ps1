$ErrorActionPreference = 'Stop'

$packageName = 'renamemytvseries2'
$url = 'https://www.tweaking4all.com/?wpfb_dl=148'
$checksum = '2215973e4820888b908026a91f8a82bbddb89af8631948545a6861d0dd40566f'
$checksumType = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url
  silentArgs     = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes = @(0)
  checksum       = $checksum
  checksumType   = $checksumType
}

Install-ChocolateyPackage @packageArgs
