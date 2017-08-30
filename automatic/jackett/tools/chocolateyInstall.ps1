$ErrorActionPreference = 'Stop'

$packageName = 'jackett'
$url = 'https://github.com/Jackett/Jackett/releases/download/v0.8.136/Jackett.Installer.Windows.exe'
$checksum = 'b26651bca7026c7e0309c3dc994f5c52360ad018c5d0ba365585bf8f8ce149e2'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
  checksum       = $checksum
  checksumType   = 'sha256'
}

Install-ChocolateyPackage @packageArgs
