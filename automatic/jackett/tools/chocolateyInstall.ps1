$packageName = 'jackett'
$installerType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$url = 'https://github.com/Jackett/Jackett/releases/download/v0.7.1662/Jackett.Installer.Windows.exe'
$checksum = 'f4246e92c6d45fe9b1a9cdb6ba0dc9fa0f5ee9dfc9dfc82676f709bf95d78d6b'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
  -FileType "$installerType" `
  -SilentArgs "$silentArgs" `
  -Url "$url" `
  -ValidExitCodes $validExitCodes `
  -Checksum "$checksum" `
  -ChecksumType "$checksumType"
