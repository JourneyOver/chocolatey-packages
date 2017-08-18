$ErrorActionPreference = 'Stop'

$packageName = 'axcrypt'
$url32 = 'https://account.axcrypt.net/download/axcrypt-2-setup.exe'
$checksum32 = '6d2ecebb869be36e0bf2b48f63ea6e7c1e8cf27c8e08f9a892dedb69295c74ba'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url32
  silentArgs     = "/S"
  validExitCodes = @(0)
  checksum       = $checksum32
  checksumType   = 'sha256'
}

Install-ChocolateyPackage @packageArgs
