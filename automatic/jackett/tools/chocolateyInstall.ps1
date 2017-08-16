$packageName = 'jackett'
$installerType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$url = 'https://github.com/Jackett/Jackett/releases/download/v0.8.59/Jackett.Installer.Windows.exe'
$checksum = '1096802c14bdf3ca4ee5c8d98a329cb833254d0338d81f43edac15c98f9f62b1'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
  -FileType "$installerType" `
  -SilentArgs "$silentArgs" `
  -Url "$url" `
  -ValidExitCodes $validExitCodes `
  -Checksum "$checksum" `
  -ChecksumType "$checksumType"
