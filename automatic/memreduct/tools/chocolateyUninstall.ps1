$ErrorActionPreference = 'Stop'

$packageName = 'memreduct'
$programUninstallEntryName = 'Mem Reduct*'

$file = "$env:ProgramFiles\Mem Reduct\uninstall.exe"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  silentArgs     = '/S'
  validExitCodes = @(0)
  file           = $file
}

Uninstall-ChocolateyPackage @packageArgs
