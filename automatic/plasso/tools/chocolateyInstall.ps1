$ErrorActionPreference = 'Stop'
$ServerOS = (Get-WmiObject -Class Win32_OperatingSystem).Caption
$pp = Get-PackageParameters

$packageName = 'plasso'
$url = 'https://bitsum.com/files/processlassosetup32.exe'
$url64 = 'https://bitsum.com/files/processlassosetup64.exe'
$checksum = 'c7d240a26cc590634edbc04a9b87600c8423ce3ed51e537782a1a127a5a9d07e'
$checksum64 = '8b4454f93bfb5b4d1c9da2c05b4073b9dd4375d78447c6643282edc3e9ec8644'

$checksumType = 'sha256'

$surl = 'https://bitsum.com/files/server/processlassosetup32.exe'
$surl64 = 'https://bitsum.com/files/server/processlassosetup64.exe'
$schecksum = 'd50acd0cd38b7f208dc1f33619e597ff5ac8b15320af24dd45ce3a4f60dd1dfd'
$schecksum64 = 'ecdabd02eff63ec5d1f7958c734968fab540928ed43bfbe71a6ee5b97d178986'

if (!$pp['language']) { $pp['language'] = 'English' }
if (!$pp['gui_start_type']) { $pp['gui_start_type'] = 'all,uac' }
if (!$pp['governor_start_type']) { $pp['governor_start_type'] = 'all,uac' }
if (!$pp['launch_gui']) { $pp['launch_gui'] = 'false' }
if (!$pp['logfolder']) { $pp['logfolder'] = "$env:APPDATA\ProcessLasso\logs" }
if (!$pp['configfolder']) { $pp['configfolder'] = "$env:APPDATA\ProcessLasso\config" }

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url
  url64Bit       = $url64
  silentArgs     = "/S /language=$($pp['language']) /gui_start_type=$($pp['gui_start_type']) /governor_start_type=$($pp['governor_start_type']) /launch_gui=$($pp['launch_gui']) /logfolder=$($pp['logfolder']) /configfolder=$($pp['configfolder'])"
  validExitCodes = @(0)
  checksum       = $checksum
  checksum64     = $checksum64
  checksumType   = $checksumType
  checksumType64 = $checksumType
}

if ($ServerOS -match "Server") {
  Write-Host 'Installing Server Version'
  $packageArgs.url = $surl
  $packageArgs.url64Bit = $surl64
  $packageArgs.checksum = $schecksum
  $packageArgs.checksum64 = $schecksum64
  Install-ChocolateyPackage @packageArgs
} else {
  Write-Host 'Installing Workstations Version'
  Install-ChocolateyPackage @packageArgs
}
