Import-Module au

$releases_32 = 'http://static.centbrowser.com/installer_32/'
$releases_64 = 'http://static.centbrowser.com/installer_64/'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "([$]url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
      "([$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
      "([$]checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
      "([$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
    }
  }
}

function global:au_GetLatest {
  $download_page_32 = Invoke-WebRequest -Uri $releases_32 -UseBasicParsing
  $download_page_64 = Invoke-WebRequest -Uri $releases_64 -UseBasicParsing

  $regex = '.exe$'
  $url_32 = $download_page_32.links | Where-Object href -match $regex | Select-Object -Last 2 -expand href
  $url_64 = $download_page_64.links | Where-Object href -match $regex | Select-Object -Last 2 -expand href

  $version = $url_32[0] -split 'centbrowser_|.exe' | Select-Object -Last 1 -Skip 1
  $version64 = $url_64[0] -split 'centbrowser_|_x64.exe' | Select-Object -Last 1 -Skip 1

  if ($version -ne $version64) {
    throw "32-bit and 64-bit version do not match. Please investigate."
  }

  $url32 = $releases_32 + $url_32[0]
  $url64 = $releases_64 + $url_64[0]

  $Latest = @{ PackageName = 'CentBrowser'; URL32 = $url32; URL64 = $url64; Version = $version }
  return $Latest
}

update
