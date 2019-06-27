. "$PSScriptRoot\..\..\scripts\Run-PesterTests.ps1"

$packageName = Split-Path -Leaf $PSScriptRoot

Run-PesterTests `
  -packageName "$packageName" `
  -packagePath "$PSScriptRoot" `
  -streams "v2", "v3" `
  -expectedEmbeddedMatch '^tmm_.+_*_win\.zip$' `
  -licenseShouldMatch 'Apache License' `
  -expectedDefaultDirectory "${env:SystemDrive}\Tools\tmm"
