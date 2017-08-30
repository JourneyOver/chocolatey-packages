$ErrorActionPreference = 'Stop'

$packageName = 'axcrypt'
$url = 'https://account.axcrypt.net/download/AxCrypt-2-Setup.exe'
$checksum = 'ff8e1b411cdef0f55ad5a7bfd568891376a58c567024c02201f40b9491279350'
$registryPath = $('HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{9E15EF89-8322-C117-CAF2-E79EFAC71395}')
$version = '2.1.1534'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url
  silentArgs     = '/S'
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
    "AxCrypt $installedVersion is already installed. " +
    "Skipping download and installation."
  )
} else {
  Install-ChocolateyPackage @packageArgs
}