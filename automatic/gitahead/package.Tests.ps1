. "$PSScriptRoot\..\..\scripts\Run-PesterTests.ps1"

Run-PesterTests `
  -packageName "gitahead" `
  -packagePath "$PSScriptRoot" `
  -expectedEmbeddedMatch '^GitAhead-win(32|64)-[\d\.]+\.exe$' `
  -licenseShouldMatch 'MIT License' `
  -expectedDefaultDirectory "${env:ProgramFiles}\GitAhead" `
  -test32bit
