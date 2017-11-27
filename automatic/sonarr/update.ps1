Import-Module au

$releases = 'https://sonarr.tv'
$vers = 'https://github.com/Sonarr/Sonarr/releases'

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*url(32)?\:\s*).*"         = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum(32)?\:\s*).*"    = "`${1}$($Latest.Checksum32)"
      "(?i)(^\s*checksum\s*type\:\s*).*"  = "`${1}$($Latest.ChecksumType32)"
    }
  }
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $vers_page = Invoke-WebRequest -Uri $vers -UseBasicParsing

  $regex = '.exe$'
  $url = $download_page.links | Where-Object href -match $regex | ForEach-Object href | Select-Object -First 1

  $versionRegEx = 'v(\d+)\.(\d+)\.(\d+)\.(\d+)'
  $version = ([regex]::match($vers_page.Content, $versionRegEx)) -replace ('v','')

  $Latest = @{ URL32 = $url; Version = $version }
  return $Latest
}

update -ChecksumFor none
