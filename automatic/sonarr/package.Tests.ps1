. "$PSScriptRoot\..\..\scripts\Run-PesterTests.ps1"

$packageName = Split-Path -Leaf $PSScriptRoot

Run-PesterTests `
    -packageName "$packageName" `
    -packagePath "$PSScriptRoot" `
    -streams "phantom" `
    -expectedEmbeddedMatch '^Sonarr\.phantom-develop\.[\d\.]+\.windows\.exe$' `
    -licenseShouldMatch 'GNU GENERAL PUBLIC LICENSE' `
    -expectedDefaultDirectory "${env:ProgramData}\Sonarr"
