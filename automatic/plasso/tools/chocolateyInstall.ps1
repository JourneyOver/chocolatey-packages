$ErrorActionPreference = 'Stop'
$ServerOS = (Get-WmiObject -Class Win32_OperatingSystem).Caption
$pp = Get-PackageParameters

$packageName = 'plasso'
$url = 'https://bitsum.com/files/processlassosetup32.exe'
$url64 = 'https://bitsum.com/files/processlassosetup64.exe'
$checksum = 'caf1204fee70129366e3eba6dbe7ea97c6b7fe64665fab0b60850007564f8aae'
$checksum64 = '16610d66d53053d9eaf74f145cf31a6800f87e37609f03b2f15ce599f7ec7910'

$checksumType = 'sha256'

$surl = 'https://bitsum.com/files/server/processlassosetup32.exe'
$surl64 = 'https://bitsum.com/files/server/processlassosetup64.exe'
$schecksum = 'febbffde7582cbee01a7d6a5cf91d70158bc613c106f91296861de50f831ca38'
$schecksum64 = '239d5adf3df3024d8d121c40aa2530a4bf9e3034f13c89aba2df69f48ed49313'

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
