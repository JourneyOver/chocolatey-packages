$ErrorActionPreference = 'Stop'

$packageName = 'nuclear'
$programUninstallEntryName = 'nuclear*'

$registry = Get-UninstallRegistryKey -SoftwareName $programUninstallEntryName
$file = $registry.UninstallString -replace ('/currentuser', '')

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  silentArgs     = '/currentuser /S'
  validExitCodes = @(0)
  file           = $file
}

Uninstall-ChocolateyPackage @packageArgs
