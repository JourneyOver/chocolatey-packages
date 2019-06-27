$ErrorActionPreference = 'Stop'

$packageName = 'mo2'

$file = "${env:SystemDrive}\Modding\MO2\unins000.exe"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
  file           = $file
}

Uninstall-ChocolateyPackage @packageArgs
