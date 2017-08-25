$ErrorActionPreference = 'Stop'

$packageName = 'tsedat'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  silentArgs     = "/S"
  validExitCodes = @(0, 3010, 1605, 1614, 1641)
  File           = "$env:LOCALAPPDATA\TheSage\Uninstall.exe"
}

Uninstall-ChocolateyPackage @packageArgs