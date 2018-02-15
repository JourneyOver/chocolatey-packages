Import-Module au

$releases = 'http://release.tinymediamanager.org/'

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*url(32)?\:\s*).*"        = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum(32)?\:\s*).*"   = "`${1}$($Latest.Checksum32)"
      "(?i)(^\s*checksum\s*type\:\s*).*" = "`${1}$($Latest.ChecksumType32)"
    }
  }
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  #tmm_2.9.7_8513bee_win.zip
  $re = "tmm_.+_*_win.zip"
  $url = $download_page.links | Where-Object href -match $re | Select-Object -First 1 -expand href

  $version = $url -split 'tmm_|_.+_win.zip' | Select-Object -Last 1 -Skip 1
  $url32 = 'https://release.tinymediamanager.org/' + $url

  $Latest = @{ URL32 = $url32; Version = $version }
  return $Latest
}

update -ChecksumFor none
