$ErrorActionPreference = 'Stop'
$ServerOS = (Get-WmiObject -class Win32_OperatingSystem).Caption

$packageName = 'plasso'
$url32 = 'https://bitsum.com/files/processlassosetup32.exe'
$url64 = 'https://bitsum.com/files/processlassosetup64.exe'
$checksum32 = '98f17ecaa61d08e75fc466e3f3fa43a8ab39744c0c7c8707da86ce1bddf9dffb'
$checksum64 = '7558e631c38c27d96135df9cfedf6a97a85e85aca169ef045bdba0fa39dd1f85'

$surl32 = 'https://bitsum.com/files/server/processlassosetup32.exe'
$surl64 = 'https://bitsum.com/files/server/processlassosetup64.exe'
$schecksum32 = '07b11b7c56f494e14076a79b23d18e95acac4a70a31ff99022a1d75e03e8ed50'
$schecksum64 = '6a0a043e3ee78601c332bae2d17fb5d8e16369ca39bd6cfa5a03ba74100a247a'

$registryPath = $('HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ProcessLasso')
$version = '9.0.0.402'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url32
  url64Bit       = $url64
  silentArgs     = '/S'
  validExitCodes = @(0)
  checksum       = $checksum32
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}

If ($ServerOS -match "Server") {
  write-host Installing Server Version
  $packageArgs.url = $surl32
  $packageArgs.url64Bit = $surl64
  $packageArgs.checksum = $schecksum32
  $packageArgs.checksum64 = $schecksum64
} Else {
  write-host Installing Workstations Version
}

if (Test-Path $registryPath) {
  $installedVersion = (
    Get-ItemProperty -Path $registryPath -Name 'DisplayVersion'
  ).DisplayVersion
}

if ($installedVersion -match $version) {
  Write-Output $(
    "Process Lasso $installedVersion is already installed. " +
    "Skipping download and installation."
  )
} else {
  Install-ChocolateyPackage @packageArgs
}
