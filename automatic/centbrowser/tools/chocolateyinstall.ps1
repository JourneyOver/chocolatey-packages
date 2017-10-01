$ErrorActionPreference = 'Stop'

$packageName = 'CentBrowser'
$url = 'http://static.centbrowser.com/installer_32/centbrowser_2.9.4.39.exe'
$url64 = 'http://static.centbrowser.com/installer_64/centbrowser_2.9.4.39_x64.exe'
$checksum = 'e8be3065ccfc8c11aefd5b51f14a6bf95bbff9261f3e498067b3867441131e4f'
$checksum64 = '770ccaedf7e3151d7eb8d8d46c0653b18c9d0fec92c7ad158fd11f9316d8f35d'
$registrypaths = @('HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\CentBrowser', 'HKCU:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\CentBrowser')
$version = '2.9.4.39'

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

if ($installedVersion -eq $version) {
  Write-Output $(
    "Cent Browser $installedVersion is already installed. " +
    "Skipping download and installation."
  )
} else {
  Install-ChocolateyPackage @packageArgs
}
