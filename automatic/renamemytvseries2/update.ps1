Import-Module au

$releases = 'https://www.tweaking4all.com/home-theatre/rename-my-tv-series-v2/'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*[$]url(32)?\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*[$]checksum(32)?\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*[$]checksumType\s*=\s*)('.*')"  = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {
  $download = Invoke-WebRequest -Uri $releases -UseBasicParsing -Headers @{ "Accept-Encoding" = 'gzip' }

  $versionRegEx = 'RenameMyTVSeries-(\d+).(\d+).(\d+)-Windows-32bit-setup.exe'
  $version = ([regex]::match($download.Content, $versionRegEx) -replace ('RenameMyTVSeries-|-Windows-32bit-setup.exe', ''))

  $url32 = 'https://www.tweaking4all.com/?wpfb_dl=148'

  # Check checksum of url to determine if checksums are out of date.
  $current_checksum = (Get-Item ".\tools\chocolateyInstall.ps1" | Select-String '^[$]checksum\b') -split "=|'" | Select-Object -Last 1 -Skip 1
  if ($current_checksum.Length -ne 64) { throw "Can't find current checksum" }
  $remote_checksum = Get-RemoteChecksum $url32
  $Notation = Get-Date -UFormat "%Y%m%d"
  if ($current_checksum -ne $remote_checksum) {
    Write-Host 'Remote checksum is different then the current one, forcing update'
    $version = $version -replace ('b', ".$Notation")
    $global:au_old_force = $global:au_force
    $global:au_force = $true
  }

  $Latest = @{ URL32 = $url32; Version = $version -replace ('b', '') }
  return $Latest
}

update -ChecksumFor 32
