Import-Module au

$releases = 'http://swift.im/downloads.html'
$fjoin = 'http://swift.im'
$clog = 'http://swift.im/'

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*url(32)?\:\s*).*"         = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum(32)?\:\s*).*"    = "`${1}$($Latest.Checksum32)"
      "(?i)(^\s*checksum\s*type\:\s*).*"  = "`${1}$($Latest.ChecksumType32)"
    }

    ".\swift-im.nuspec"        = @{
      "(\*\s+\[(\w+)\])(.*)" = "`$1($($Latest.Changelog))"
    }
  }
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $regex = '.msi$'
  $url = $download_page.links | Where-Object href -Match $regex | Select-Object -First 1 -Expand href

  $regex = 'changelog-'
  $changelogx = $download_page.links | Where-Object href -Match $regex | Select-Object -First 1 -Expand href

  $version = $url -split 'swift-|.msi' | Select-Object -Last 1 -Skip 1
  $url32 = $fjoin + $url
  $changelog = $clog + $changelogx

  $Latest = @{ URL32 = $url32; Version = $version; Changelog = $changelog }
  return $Latest
}

update -ChecksumFor none
