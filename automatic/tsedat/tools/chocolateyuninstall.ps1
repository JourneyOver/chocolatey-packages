$ErrorActionPreference = 'Stop'

$packageName = 'tsedat'
$programUninstallEntryName = 'TheSage*'

$registry = Get-UninstallRegistryKey -SoftwareName $programUninstallEntryName
$file = $registry.UninstallString

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  silentArgs     = '/S'
  validExitCodes = @(0, 3010, 1605, 1614, 1641)
  file           = $file
}

Uninstall-ChocolateyPackage @packageArgs