$packageName = 'jackett'
$installerType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$url = 'https://github.com/Jackett/Jackett/releases/download/v0.8.86/Jackett.Installer.Windows.exe'
$checksum = 'aa13dee78973119971aaeefd7af13d53f71f6cafe967435a42fa1caf3259c273'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
  -FileType "$installerType" `
  -SilentArgs "$silentArgs" `
  -Url "$url" `
  -ValidExitCodes $validExitCodes `
  -Checksum "$checksum" `
  -ChecksumType "$checksumType"
