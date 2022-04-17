Import-Module au

$releases = 'https://www.sequencepublishing.com/_files/'

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
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $regex = 'TheSage_Setup_'
  $url = $download_page.links | Where-Object href -Match $regex

  $realnum = $url -split 'TheSage_Setup_|.exe' | Select-Object -Last 1 -Skip 1

  $version = $realnum -replace ('-', '.');
  $url32 = $releases + 'TheSage_Setup_0-0-0000.exe' -replace ("(\d+)\-(\d+)\-(\d+)", "$realnum");

  $Latest = @{ URL32 = $url32; Version = $version }
  return $Latest
}

try {
  update -ChecksumFor 32
} catch {
  $ignore = '403 Forbidden'
  if ($_ -match $ignore) { Write-Host $ignore; 'ignore' }  else { throw $_ }
}
