Import-Module au

$releases = 'https://sonarr.tv'

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

  $regex = 'installer=true'
  $url = $download_page.links | Where-Object href -match $regex | ForEach-Object href | Select-Object -First 1 | % { ($_) -replace ('//s', 'https://s') } | % { Get-RedirectedUrl ($_) } | % { ($_) -replace ('zip', 'exe') }

  $dest = "$env:TEMP\Sonarr_phantom.exe"

  Invoke-WebRequest -Uri $url -OutFile $dest
  $version = (Get-Item $dest).VersionInfo.FileVersion -replace ('\s', '')
  $build = "-beta"
  rm -force $dest

  $Latest = @{ packageName = 'sonarr'; URL32 = $url; Version = ($version + $build)}
  return $Latest
}

update -ChecksumFor none
