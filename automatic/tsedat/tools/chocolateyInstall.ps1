$ErrorActionPreference = 'Stop'

$packageName = 'tsedat'
$url = 'https://www.sequencepublishing.com/_files/TheSage_Setup_7-52-2806.exe'
$checksum = 'faddfdd5ac78d73b354fbd2d270df665b3d53febd129eff227bc37dd72a059ab'
$checksumType = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url
  silentArgs     = '/S'
  validExitCodes = @(0)
  checksum       = $checksum
  checksumType   = $checksumType
}

Install-ChocolateyPackage @packageArgs
