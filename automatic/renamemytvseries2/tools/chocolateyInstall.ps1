$ErrorActionPreference = 'Stop'

$packageName = 'renamemytvseries2'
$url = 'https://www.tweaking4all.com/?wpfb_dl=148'
$checksum = '043680b06f81f24a1abf374dfbad519189e0fb7da6958d672e1ed09695d56200'
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
