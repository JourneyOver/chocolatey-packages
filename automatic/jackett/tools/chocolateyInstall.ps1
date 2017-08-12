$packageName = 'jackett'
$installerType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$url = 'https://github.com/Jackett/Jackett/releases/download/v0.8.10/Jackett.Installer.Windows.exe'
$checksum = '32e3703c02cbf48a5c3eb00d0991dd0a38f446dee7e959c0cca6d71cba506b65'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
  -FileType "$installerType" `
  -SilentArgs "$silentArgs" `
  -Url "$url" `
  -ValidExitCodes $validExitCodes `
  -Checksum "$checksum" `
  -ChecksumType "$checksumType"
