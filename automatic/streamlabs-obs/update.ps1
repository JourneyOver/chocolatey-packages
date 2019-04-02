Import-Module au

$releases = 'https://streamlabs.com/slobs/download'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*[$]url(64)?\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*[$]checksum(64)?\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
      "(?i)(^\s*[$]checksumType\s*=\s*)('.*')"  = "`$1'$($Latest.ChecksumType64)'"
    }
  }
}

function global:au_GetLatest {
  $url = Get-RedirectedUrl $releases

  $version = $url -split 'Setup\+|\.exe' | Select-Object -Last 1 -Skip 1
  $url64 = $url -replace ('\?installer_id=[a-zA-Z0-9]+', '')

  $Latest = @{ URL64 = $url64; Version = $version }
  return $Latest
}

update -ChecksumFor 64
