import-module au

$releases = 'https://github.com/SchizoDuckie/DuckieTV/releases'

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

  $regex = 'x(\d+).zip$'
  $url = $download_page.links | Where-Object href -match $regex | ForEach-Object href | Select-Object -First 1

  $version = (Split-Path ( Split-Path $url ) -Leaf)

  $url32 = 'https://github.com' + $url
  $url64 = 'https://github.com' + $url -replace ('x32', 'x64')

  $Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
  return $Latest
}

update