. "$PSScriptRoot\..\..\scripts\Run-PesterTests.ps1"

Run-PesterTests `
  -packageName "axcrypt" `
  -packagePath "$PSScriptRoot" `
  -expectedEmbeddedMatch '^axcrypt-[\d\.]+-setup\.exe$' `
  -licenseShouldMatch 'GNU GENERAL PUBLIC LICENSE' `
  -expectedDefaultDirectory "${env:ProgramData}\Package Cache\{4802bd28-932d-4070-99e2-068ea74d872d}"
