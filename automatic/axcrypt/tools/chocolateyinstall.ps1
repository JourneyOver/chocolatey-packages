$ErrorActionPreference = 'Stop'

$packageName = 'axcrypt'
$url = 'https://account.axcrypt.net/download/AxCrypt-2-Setup.exe'
$checksum = '3008e96379f1bb72beaf1aaae333e0977f3ba3073d08986a8e9b290eb8656b58'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url
  silentArgs     = "/S"
  validExitCodes = @(0)
  checksum       = $checksum
  checksumType   = 'sha256'
}

Install-ChocolateyPackage @packageArgs
