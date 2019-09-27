. "$PSScriptRoot\..\..\scripts\Run-PesterTests.ps1"

$packageName = Split-Path -Leaf $PSScriptRoot

Run-PesterTests `
  -packageName "$packageName" `
  -packagePath "$PSScriptRoot" `
  -expectedEmbeddedMatch '^Lidarr\.(master|develop)\.[\d\.]+\.windows-installer\.exe$' `
  -licenseShouldMatch 'GNU GENERAL PUBLIC LICENSE' `
  -expectedDefaultDirectory "${env:ProgramData}\Lidarr"
