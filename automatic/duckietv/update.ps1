Import-Module au

$releases = 'https://github.com/SchizoDuckie/DuckieTV/releases'

function global:au_SearchReplace {
  @{
    ".\legal\verification.txt" = @{
      "(?i)(url:\s+).*"        = "`${1}$($Latest.URL32)"
      "(?i)(url64:\s+).*"      = "`${1}$($Latest.URL64)"
      "(?i)(checksum:\s+).*"   = "`${1}$($Latest.Checksum32)"
      "(?i)(checksum64:\s+).*" = "`${1}$($Latest.Checksum64)"
    }
  }
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $regex = 'x(\d+).zip$'
  $url = $download_page.links | Where-Object href -match $regex | ForEach-Object href | Select-Object -First 2

  $version = (Split-Path ( Split-Path $url[0] ) -Leaf)

  $url32 = 'https://github.com' + $url[0]
  $url64 = 'https://github.com' + $url[1]

  $Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
  return $Latest
}

update -ChecksumFor none
