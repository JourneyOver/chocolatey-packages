$ErrorActionPreference = 'Stop'

$packageName = 'renamemytvseries2'
$url = 'https://www.tweaking4all.com/?wpfb_dl=148'
$checksum = 'e94397eb92bd600fe2d05eafddae665f66e74c1e731a838b4d72fbf7d7cf9df0'
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
