import-module au

$releases = 'https://github.com/Radarr/Radarr/releases'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "(?i)(checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $url32 = $download_page.links | Where-Object href -match '.exe$' | ForEach-Object href | Select-Object -First 1

  $version = (Split-Path ( Split-Path $url32 ) -Leaf).Substring(1)

  @{
    URL32   = 'https://github.com' + $url32
    Version = $version
  }
}

update