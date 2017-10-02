$ErrorActionPreference = 'Stop'

$packageName = ''
$programUninstallEntryName = '*'

$registry = Get-UninstallRegistryKey -SoftwareName $programUninstallEntryName
$file = $registry.UninstallString

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'msi'
  silentArgs     = '/quiet /qn /norestart'
  validExitCodes = @(0, 3010, 1641)
  file           = $file
}

Uninstall-ChocolateyPackage @packageArgs
