$ErrorActionPreference = 'Stop'

$packageName = 'jackett'
$url = 'https://github.com/Jackett/Jackett/releases/download/v0.8.225/Jackett.Installer.Windows.exe'
$checksum = '5540e0d687c2f5c18bf896b665b148ac9b396439e7389926cdba3e8b2c0c3823'
$registryPath = $('HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C2A9FC00-AA48-4F17-9A72-62FBCEE2785B}_is1')
$version = '0.8.225'

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
