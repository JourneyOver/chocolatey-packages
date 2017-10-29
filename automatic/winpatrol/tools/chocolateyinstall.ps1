$ErrorActionPreference = 'Stop'

$packageName = 'winpatrol'
$url = 'https://data.winpatrol.com/downloads/wpsetup.exe'
$checksum = '5EE0B4EA12EBF1BF8EE8CF5DED16F923CD08652EFFA7F7302CB6206E4BE0FBAC'
$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$registrypaths = @('HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{6A206A04-6BC1-411B-AA04-4E52EDEEADF2}', 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{6A206A04-6BC1-411B-AA04-4E52EDEEADF2}')
$version = '35.5.2017.8'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url
  silentArgs     = ''
  validExitCodes = @(0)
  checksum       = $checksum
  checksumType   = 'sha256'
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
    "winpatrol $installedVersion is already installed. " +
    "Skipping download and installation."
  )
} else {
  Start-Process 'AutoHotkey' "$toolsPath\install.ahk"
  Install-ChocolateyPackage @packageArgs
}
