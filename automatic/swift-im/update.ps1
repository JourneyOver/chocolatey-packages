Import-Module au

$releases = 'http://swift.im/downloads.html'
$fjoin = 'http://swift.im'
$clog = 'http://swift.im/'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "([$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "([$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
    }

    ".\swift-im.nuspec"             = @{
      "(\*\s+\[(\w+)\])(.*)" = "`$1($($Latest.Changelog))"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $regex = '.msi$'
  $url = $download_page.links | Where-Object href -match $regex | Select-Object -First 1 -expand href

  $regex = 'changelog-'
  $changelogx = $download_page.links | Where-Object href -match $regex | Select-Object -First 1 -expand href

  $version = $url -split 'swift-|.msi' | Select-Object -Last 1 -Skip 1
  $url32 = $fjoin + $url
  $changelog = $clog + $changelogx

  $Latest = @{URL32 = $url32; Version = $version; Changelog = $changelog }
  return $Latest
}

update -ChecksumFor 32