$ErrorActionPreference = 'Stop'

$packageName = 'tsedat'
$url = 'http://www2.fs.u-bunkyo.ac.jp/~gilner/_files/TheSage_Setup_7-18-2678.exe'
$checksum = '7347b717823c95d7ca9b31badef89a4157023a500611d483abf7a44003c5babe'
$registryPath = $('HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TheSage-7')
$version = '7.18.2678'

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

if ($installedVersion -eq $version) {
  Write-Output $(
    "TheSage English Dictionary and Thesaurus $installedVersion is already installed. " +
    "Skipping download and installation."
  )
} else {
  Install-ChocolateyPackage @packageArgs
}