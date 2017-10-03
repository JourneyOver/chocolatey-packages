$ErrorActionPreference = 'Stop'

$packageName = ''
$programUninstallEntryName = '*'

$registry = Get-UninstallRegistryKey -SoftwareName $programUninstallEntryName
$file = $registry.UninstallString

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  silentArgs     = '/S'
  validExitCodes = @(0)
  file           = $file
}

Uninstall-ChocolateyPackage @packageArgs
