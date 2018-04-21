$ErrorActionPreference = 'Stop'

$packageName = 'leonflix'
$url = 'https://leonflix.net/downloads/Leonflix-Installer.exe'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
