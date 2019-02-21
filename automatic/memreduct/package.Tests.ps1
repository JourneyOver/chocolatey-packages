. "$PSScriptRoot\..\..\scripts\Run-PesterTests.ps1"

$packageName = Split-Path -Leaf $PSScriptRoot

Run-PesterTests `
  -packageName "$packageName" `
  -packagePath "$PSScriptRoot" `
  -expectedEmbeddedMatch '^memreduct-[\d\.]+-setup\.exe$' `
  -licenseShouldMatch 'GNU GENERAL PUBLIC LICENSE' `
  -expectedDefaultDirectory "${env:ProgramFiles}\Mem Reduct"

Describe "memreduct ini file" {
  Context "Is it created?" {
    It "Should have created a ini file in the programs install folder" {
      $cdirectory = [System.Environment]::GetFolderPath('ProgramFiles')
      "$cdirectory\Mem Reduct\memreduct.ini" | Should -Exist
    }
  }
}
