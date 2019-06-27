. "$PSScriptRoot\..\..\scripts\Run-PesterTests.ps1"

$packageName = Split-Path -Leaf $PSScriptRoot

Run-PesterTests `
  -packageName "$packageName" `
  -packagePath "$PSScriptRoot" `
  -expectedEmbeddedMatch '^tmm\_[\d\.]+\_win\.zip$' `
  -licenseShouldMatch 'Apache License' `
  -expectedDefaultDirectory "${env:SystemDrive}\Tools\tmm"
