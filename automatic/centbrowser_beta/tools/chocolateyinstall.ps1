$ErrorActionPreference = 'Stop'

$packageName = 'CentBrowser'
$url = 'http://static.centbrowser.com/beta_32/centbrowser_2.9.3.26.exe'
$url64 = 'http://static.centbrowser.com/beta_64/centbrowser_2.9.3.26_x64.exe'
$checksum = '16d65b37c3c040edeb93c0d6f612d1226cd7736540aa7f2926833a74f4b9ecd9'
$checksum64 = '7254908504a13e38df1caca0c905e8243d942ca9a91ade7f21de4f46c2fbd8e9'
$registrypaths = @('HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\CentBrowser', 'HKCU:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\CentBrowser')
$version = '2.9.3.26-beta'
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
