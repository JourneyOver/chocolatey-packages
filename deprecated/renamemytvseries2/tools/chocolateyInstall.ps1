$ErrorActionPreference = 'Stop'

$packageName = 'renamemytvseries2'
$url = 'https://www.tweaking4all.com/downloads/video/RenameMyTVSeries-2.0.10-Windows-32bit-setup.exe'
$checksum = '086b1bd8bce703ae09190948cb48a3e1705e981e3043fb56eed52d411cbbbe83'
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
