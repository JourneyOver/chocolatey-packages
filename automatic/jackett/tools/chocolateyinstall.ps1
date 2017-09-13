$ErrorActionPreference = 'Stop'

$packageName = 'jackett'
$url = 'https://github.com/Jackett/Jackett/releases/download/v0.8.190/Jackett.Installer.Windows.exe'
$checksum = 'cd62fdb1b3100998446df1429ad41f595f55a45844c98e902c81f2332eb92dac'
$registryPath = $('HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C2A9FC00-AA48-4F17-9A72-62FBCEE2785B}_is1')
$version = '0.8.190'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
  checksum       = $checksum
  checksumType   = 'sha256'
}

if (Test-Path $registryPath) {
  $installedVersion = (
    Get-ItemProperty -Path $registryPath -Name 'DisplayVersion'
  ).DisplayVersion
}

if ($installedVersion -match $version) {
  Write-Output $(
    "Jackett $installedVersion is already installed. " +
    "Skipping download and installation."
  )
} else {
  Install-ChocolateyPackage @packageArgs
}
