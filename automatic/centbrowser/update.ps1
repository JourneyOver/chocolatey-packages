Import-Module au

$releases_32 = 'http://static.centbrowser.com/installer_32/'
$releases_64 = 'http://static.centbrowser.com/installer_64/'

$breleases_32 = 'http://static.centbrowser.com/beta_32/'
$breleases_64 = 'http://static.centbrowser.com/beta_64/'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*[$]url(32)?\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*[$]url64\s*=\s*)('.*')"         = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*[$]checksum(32)?\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*[$]checksum64\s*=\s*)('.*')"    = "`$1'$($Latest.Checksum64)'"
      "(?i)(^\s*[$]checksumType\s*=\s*)('.*')"  = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {
  $download_page_32 = Invoke-WebRequest -Uri $releases_32 -UseBasicParsing
  $download_page_64 = Invoke-WebRequest -Uri $releases_64 -UseBasicParsing
  $bdownload_page_32 = Invoke-WebRequest -Uri $breleases_32 -UseBasicParsing
  $bdownload_page_64 = Invoke-WebRequest -Uri $breleases_64 -UseBasicParsing

  $regex = '.exe$'

  $url_32 = $download_page_32.links | Where-Object href -Match $regex | Select-Object -Last 2 -Expand href
  $url_64 = $download_page_64.links | Where-Object href -Match $regex | Select-Object -Last 2 -Expand href
  $version = $url_32[0] -split 'centbrowser_|.exe' | Select-Object -Last 1 -Skip 1
  $version64 = $url_64[0] -split 'centbrowser_|_x64.exe' | Select-Object -Last 1 -Skip 1

  if ($version -ne $version64) {
    throw "32-bit and 64-bit versions do not match. Please investigate."
  }

  $burl_32 = $bdownload_page_32.links | Where-Object href -Match $regex | Select-Object -Last 2 -Expand href
  $burl_64 = $bdownload_page_64.links | Where-Object href -Match $regex | Select-Object -Last 2 -Expand href
  $bversion = $burl_32[0] -split 'centbrowser_|.exe' | Select-Object -Last 1 -Skip 1
  $bversion64 = $burl_64[0] -split 'centbrowser_|_x64.exe' | Select-Object -Last 1 -Skip 1
  $build = "-beta"

  if ($bversion -ne $bversion64) {
    throw "32-bit and 64-bit beta versions do not match. Please investigate."
  }

  $url32 = $releases_32 + $url_32[0]
  $url64 = $releases_64 + $url_64[0]
  $burl32 = $breleases_32 + $burl_32[0]
  $burl64 = $breleases_64 + $burl_64[0]

  if ($bversion -gt $version) {
    $Latest = @{ packageName = 'CentBrowser'; URL32 = $burl32; URL64 = $burl64; Version = ($bversion + $build) }
    return $Latest
  } else {
    $Latest = @{ packageName = 'CentBrowser'; URL32 = $url32; URL64 = $url64; Version = $version }
    return $Latest
  }
}

update
