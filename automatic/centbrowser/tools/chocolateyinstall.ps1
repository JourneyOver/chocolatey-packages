$ErrorActionPreference = 'Stop'

$packageName = 'CentBrowser'
$url = 'http://static.centbrowser.com/installer_32/centbrowser_2.9.4.34.exe'
$url64 = 'http://static.centbrowser.com/installer_64/centbrowser_2.9.4.34_x64.exe'
$checksum = '049623030d5757dd5f2a5d88201f914f2b943c0f4b8c4e25397111c09d0c2499'
$checksum64 = '47cd44155024118ec778a1ac5a98634c5f9e2fd794cee4a41715700818573a13'
$registrypaths = @('HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\CentBrowser', 'HKCU:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\CentBrowser')
$version = '2.9.4.34'

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
