$ErrorActionPreference = 'Stop'

$packageName = 'CentBrowser'
$url = 'http://static.centbrowser.com/beta_32/centbrowser_2.8.3.34.exe'
$url64 = 'http://static.centbrowser.com/beta_64/centbrowser_2.8.3.34_x64.exe'
$checksum = '4e90868b1ce19922eb28183cd104aba99e7c4cfabd7a40ecf7de37fcf20411a2'
$checksum64 = 'b511f111645f1d1ebb46cd0ce7e4b43c40070a6a40c1ad0ffa55d34c012c2ee8'
$registrypaths = @('HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\CentBrowser', 'HKCU:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\CentBrowser')
$version = '2.8.3.34-beta'
$nobeta = $version -replace('-beta')

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url
  url64Bit       = $url64
  silentArgs     = '--cb-auto-update'
  validExitCodes = @(0)
  checksum       = $checksum
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}

Foreach ($registry in $registrypaths) {
  if (Test-Path $registry) {
    $installedVersion = (
      Get-ItemProperty -Path $registry -Name 'DisplayVersion'
    ).DisplayVersion
  }
}

if ($installedVersion -eq $nobeta) {
  Write-Output $(
    "Cent Browser $installedVersion is already installed. " +
    "Skipping download and installation."
  )
} else {
  Install-ChocolateyPackage @packageArgs
}