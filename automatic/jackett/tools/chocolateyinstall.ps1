$ErrorActionPreference = 'Stop'

$packageName = 'jackett'
$url = 'https://github.com/Jackett/Jackett/releases/download/v0.8.216/Jackett.Installer.Windows.exe'
$checksum = '6ab8da6756b4133a745b2e0568d001fbfca3dde608ca5f5a4fedfc92e0fb83b0'
$registryPath = $('HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C2A9FC00-AA48-4F17-9A72-62FBCEE2785B}_is1')
$version = '0.8.216'

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
