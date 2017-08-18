$ErrorActionPreference = 'Stop'
$ServerOS = (Get-WmiObject -class Win32_OperatingSystem).Caption

$packageName = 'plasso'
$url32 = 'https://bitsum.com/files/processlassosetup32.exe'
$url64 = 'https://bitsum.com/files/processlassosetup64.exe'
$checksum32 = 'B77ABBEB105D615EE949D936BC9C0B9690EE4790F733A39039988FC2AF9525D0'
$checksum64 = 'FEC50E6346374148796AAEF4CEC4307BCDE8D496E6D502E26049F358C596EB17'

$surl32 = 'https://bitsum.com/files/server/processlassosetup32.exe'
$surl64 = 'https://bitsum.com/files/server/processlassosetup64.exe'
$schecksum32 = 'FA36E44D5A9F26C7B1328F201391A1175D245DD0C1D12D84635AF080BEF4EE5F'
$schecksum64 = 'A0ADC29ABA2FF9CFE9A9F0A61ED34E4A73A9E94174EDD32B7F1EB2FD3618BBD2'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url32
  url64Bit       = $url64
  silentArgs     = "/S"
  validExitCodes = @(0)
  checksum       = $checksum32
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}

$spackageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $surl32
  url64Bit       = $surl64
  silentArgs     = "/S"
  validExitCodes = @(0)
  checksum       = $schecksum32
  checksum64     = $schecksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}

If ($ServerOS -match "Server") {
  Install-ChocolateyPackage @spackageArgs
  write-host Installing Server Version
}
Else {
  Install-ChocolateyPackage @packageArgs
  write-host Installing Workstations Version
}