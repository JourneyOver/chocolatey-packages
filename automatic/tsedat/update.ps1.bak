Import-Module au

$releases = 'https://sequencepublishing.com/cgi-bin/download.cgi?thesage'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*[$]url(32)?\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*[$]checksum(32)?\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*[$]checksumType\s*=\s*)('.*')"  = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_AfterUpdate($Package) {
  Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
  $url32 = Get-RedirectedUrl $releases

  $realnum = $url32 -split 'TheSage_Setup_|.exe' | Select-Object -Last 1 -Skip 1

  $version = $realnum -replace ('-', '.');

  $Latest = @{ URL32 = $url32; Version = $version }
  return $Latest
}

try {
  update -ChecksumFor 32
} catch {
  $ignore = '403 Forbidden'
  if ($_ -match $ignore) { Write-Host $ignore; 'ignore' }  else { throw $_ }
}
