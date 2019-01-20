Import-Module au

$releases = 'https://sonarr.tv'
$dev_releases = 'https://download.sonarr.tv/v2/develop/latest/'

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
  $download_page_dev = Invoke-WebRequest -Uri $dev_releases -UseBasicParsing

  $regex = '.exe$'
  $url = $download_page.links | Where-Object href -match $regex | ForEach-Object href | Select-Object -First 1
  $url_dev = $download_page_dev.links | Where-Object href -match $regex | ForEach-Object href | Select-Object -First 1 | % { ($dev_releases + $_) }

  $dest = "$env:TEMP\Sonarr.exe"
  $dest_dev = "$env:TEMP\Sonarr_dev.exe"

  Invoke-WebRequest -Uri $url -OutFile $dest
  $version = (Get-Item $dest).VersionInfo.FileVersion -replace ('\s', '')
  rm -force $dest

  Invoke-WebRequest -Uri $url_dev -OutFile $dest_dev
  $version_dev = (Get-Item $dest_dev).VersionInfo.FileVersion -replace ('\s', '')
  $build = "-beta"
  rm -force $dest_dev

  if ($version_dev -gt $version) {
    $Latest = @{ packageName = 'sonarr'; URL32 = $url_dev; Version = ($version_dev + $build) }
    return $Latest
  } else {
    $Latest = @{ packageName = 'sonarr'; URL32 = $url; Version = $version }
    return $Latest
  }
}

update -ChecksumFor none
