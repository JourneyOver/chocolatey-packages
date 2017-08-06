﻿$ErrorActionPreference = 'Stop'

$packageName = 'swift-im'
$url32 = 'http://swift.im/downloads/releases/swift-3.0/Swift-3.0.msi'
$checksum32 = '8445234e84379b582bfbe7a8450acc4229c9f9edc85548b3a5ab2aa145151d96'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'msi'
  url            = $url32
  softwareName  = 'Swift'
  silentArgs     = "/quiet /qn /norestart"
  validExitCodes = @(0)
  checksum       = $checksum32
  checksumType   = 'sha256'
}

Install-ChocolateyPackage @packageArgs
