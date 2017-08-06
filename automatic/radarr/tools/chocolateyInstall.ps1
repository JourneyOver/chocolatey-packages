$packageName = 'radarr'
$installerType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$url = 'https://github.com/Radarr/Radarr/releases/download/v0.2.0.778/Radarr.develop.0.2.0.778.installer.exe'
$checksum = '890448a07df2125de0681cb7b6f60979200d149405023bbb1fa6bfde4e90e9a9'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
  -FileType "$installerType" `
  -SilentArgs "$silentArgs" `
  -Url "$url" `
  -ValidExitCodes $validExitCodes `
  -Checksum "$checksum" `
  -ChecksumType "$checksumType"
