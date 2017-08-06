import-module au

$releases = 'https://www.centbrowser.com/history.html'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "([$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "([$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
      "([$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "([$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $regex = '.exe$'
  $url = $download_page.links | Where-Object href -match $regex | Select-Object -First 3 -expand href

  $version = $url[0] -split 'centbrowser_|.exe' | Select-Object -Last 1 -Skip 1

  $url32 = $url[0]
  $url64 = $url[2]

  $Latest = @{ URL32 = $url32; URL64 = $url64; version = $version }
  return $Latest
}

update