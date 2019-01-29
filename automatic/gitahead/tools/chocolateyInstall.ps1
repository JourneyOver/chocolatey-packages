$ErrorActionPreference = 'Stop'

$packageName = 'gitahead'
$url = 'https://github.com/gitahead/gitahead/releases/download/v2.5.3/GitAhead-win32-2.5.3.exe'
$url64 = 'https://github.com/gitahead/gitahead/releases/download/v2.5.3/GitAhead-win64-2.5.3.exe'
$checksum = 'f95ad6c6ec2f7b908e3a33a13ec80556ad9822210b603ae34a09667165345404'
$checksum64 = 'da50ca5f2a7f75575c1efbf2f6e90daa6b049e26b3be3bf6d6eda4eea253cc22'
$checksumType = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url
  url64Bit       = $url64
  silentArgs     = "/S"
  validExitCodes = @(0)
  checksum       = $checksum
  checksum64     = $checksum64
  checksumType   = $checksumType
  checksumType64 = $checksumType
}

Install-ChocolateyPackage @packageArgs
