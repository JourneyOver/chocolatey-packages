$packageName = 'jackett'
$installerType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$url = 'https://github.com/Jackett/Jackett/releases/download/v0.8.12/Jackett.Installer.Windows.exe'
$checksum = '3b220d2071b8c3d7187c4016df1d637036896257f35d4a17f90f16b59cfc2386'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
  -FileType "$installerType" `
  -SilentArgs "$silentArgs" `
  -Url "$url" `
  -ValidExitCodes $validExitCodes `
  -Checksum "$checksum" `
  -ChecksumType "$checksumType"
