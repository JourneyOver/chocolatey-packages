$ErrorActionPreference = 'Stop'

$packageName = 'plasso'
$url32 = 'https://bitsum.com/files/processlassosetup32.exe'
$url64 = 'https://bitsum.com/files/processlassosetup64.exe'
$checksum32 = 'B77ABBEB105D615EE949D936BC9C0B9690EE4790F733A39039988FC2AF9525D0'
$checksum64 = 'FEC50E6346374148796AAEF4CEC4307BCDE8D496E6D502E26049F358C596EB17'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url32
  url64Bit       = $url64
  silentArgs     = "/S"
  validExitCodes = @(0)
  checksum       = $checksum32
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}

Install-ChocolateyPackage @packageArgs
