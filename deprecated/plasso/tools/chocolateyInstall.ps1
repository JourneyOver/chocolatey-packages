$ErrorActionPreference = 'Stop'
$ServerOS = (Get-WmiObject -Class Win32_OperatingSystem).Caption
$pp = Get-PackageParameters

$packageName = 'plasso'
$url = 'https://bitsum.com/files/processlassosetup32.exe'
$url64 = 'https://bitsum.com/files/processlassosetup64.exe'
$checksum = '4d8f297e2adfa6c4cb446f2a7bc7e5b74ba9a0cb850738ab54977ff4ec067b58'
$checksum64 = '3937f74cfce336b309f6a76ef74c3819cad88bb9426e12f891f37c7617a3b705'

$checksumType = 'sha256'

$surl = 'https://bitsum.com/files/server/processlassosetup32.exe'
$surl64 = 'https://bitsum.com/files/server/processlassosetup64.exe'
$schecksum = 'e2a91427d331ffe76255f311dd5fb88968df7487673107fe0eee5c835bfb5f3a'
$schecksum64 = '438b46e653c8b0a1020b43fd0572e3814d5653267fe13afa4be13220a57792fd'

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
