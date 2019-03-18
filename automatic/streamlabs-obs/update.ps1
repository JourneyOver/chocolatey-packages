Import-Module au
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'https://streamlabs.com/slobs/download'

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*url(64)?\:\s*).*"        = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum(64)?\:\s*).*"   = "`${1}$($Latest.Checksum64)"
      "(?i)(^\s*checksum\s*type\:\s*).*" = "`${1}$($Latest.ChecksumType64)"
    }
  }
}

function global:au_BeforeUpdate($Package) {
  $licenseFile = "$PSScriptRoot\legal\LICENSE.txt"
  if (Test-Path $licenseFile) { Remove-Item -Force $licenseFile }

  Invoke-WebRequest -UseBasicParsing -Uri $($Package.nuspecXml.package.metadata.licenseUrl -replace 'blob', 'raw') -OutFile $licenseFile
  if (!(Get-ValidOpenSourceLicense -path "$licenseFile")) {
    throw "Unknown license download. Please verify it still contains distribution rights."
  }

  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
  $url = Get-RedirectedUrl $releases

  $version = $url -split 'Setup\+|\.exe' | Select-Object -Last 1 -Skip 1
  $url64 = $url -replace('\?installer_id=[a-zA-Z0-9]+','')

  $Latest = @{ URL64 = $url64; Version = $version }
  return $Latest
}

update -ChecksumFor none
