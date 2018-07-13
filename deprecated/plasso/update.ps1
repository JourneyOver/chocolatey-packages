Import-Module au

$releases = 'https://bitsum.com/changes/processlasso/'
$vrelease = 'https://bitsum.com/userservices/versioninfo.php?ProductName=ProcessLasso'

function global:au_BeforeUpdate {
  $Latest.Checksum32 = Get-RemoteChecksum $Latest.URL32
  $Latest.Checksum64 = Get-RemoteChecksum $Latest.URL64
  $Latest.SChecksum32 = Get-RemoteChecksum $Latest.SURL32
  $Latest.SChecksum64 = Get-RemoteChecksum $Latest.SURL64
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*[$]url(32)?\s*=\s*)('.*')"       = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*[$]url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*[$]checksum(32)?\s*=\s*)('.*')"  = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*[$]checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
      "(?i)(^\s*[$]surl(32)?\s*=\s*)('.*')"      = "`$1'$($Latest.SURL32)'"
      "(?i)(^\s*[$]surl64\s*=\s*)('.*')"         = "`$1'$($Latest.SURL64)'"
      "(?i)(^\s*[$]schecksum(32)?\s*=\s*)('.*')" = "`$1'$($Latest.SChecksum32)'"
      "(?i)(^\s*[$]schecksum64\s*=\s*)('.*')"    = "`$1'$($Latest.SChecksum64)'"
      "(?i)(^\s*[$]checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $version_number = Invoke-WebRequest -Uri $vrelease -UseBasicParsing

  $regex = '.exe$'
  $url = $download_page.links | Where-Object href -Match $regex | Select-Object -First 6 -Expand href

  $versionRegEx = '(\d+)\.(\d+)\.(\d+)\.(\d+)'
  $version = ([regex]::match($version_number.Content, $versionRegEx))

  $url32 = $url[1]
  $url64 = $url[0]
  $surl32 = $url[5]
  $surl64 = $url[4]

  # Check checksum of one url to determine if checksums are out of date.
  $current_checksum = (gi ".\tools\chocolateyInstall.ps1" | sls '^[$]checksum64\b') -split "=|'" | Select -Last 1 -Skip 1
  if ($current_checksum.Length -ne 64) { throw "Can't find current checksum" }
  $remote_checksum = Get-RemoteChecksum $url[0]
  if ($current_checksum -ne $remote_checksum) {
    Write-Host 'Remote checksum is different then the current one, forcing update'
    $global:au_old_force = $global:au_force
    $global:au_force = $true
  }

  if ($current_checksum -ne $remote_checksum) {
  $Latest = @{ URL32 = $url32; URL64 = $url64; SURL32 = $surl32; SURL64 = $surl64; Version = "$version" + "01" }
  } else {
  $Latest = @{ URL32 = $url32; URL64 = $url64; SURL32 = $surl32; SURL64 = $surl64; Version = "$version" + "00" }
  }
  return $Latest
}

update
if ($global:au_old_force -is [bool]) { $global:au_force = $global:au_old_force }
