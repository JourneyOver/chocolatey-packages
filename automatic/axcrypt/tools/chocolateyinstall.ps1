$ErrorActionPreference = 'Stop'

$packageName = 'axcrypt'
$url = 'https://account.axcrypt.net/download/AxCrypt-2-Setup.exe'
$checksum = '3008e96379f1bb72beaf1aaae333e0977f3ba3073d08986a8e9b290eb8656b58'
$registryPath = $('HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{9E15EF89-8322-C117-CAF2-E79EFAC71395}')
$version = '2.1.1536'

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