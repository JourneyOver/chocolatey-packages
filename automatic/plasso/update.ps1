import-module au

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
      "([$]url32\s*=\s*)('.*')"       = "`$1'$($Latest.URL32)'"
      "([$]url64\s*=\s*)('.*')"       = "`$1'$($Latest.URL64)'"
      "([$]checksum32\s*=\s*)('.*')"  = "`$1'$($Latest.Checksum32)'"
      "([$]checksum64\s*=\s*)('.*')"  = "`$1'$($Latest.Checksum64)'"
      "([$]surl32\s*=\s*)('.*')"      = "`$1'$($Latest.SURL32)'"
      "([$]surl64\s*=\s*)('.*')"      = "`$1'$($Latest.SURL64)'"
      "([$]schecksum32\s*=\s*)('.*')" = "`$1'$($Latest.SChecksum32)'"
      "([$]schecksum64\s*=\s*)('.*')" = "`$1'$($Latest.SChecksum64)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $version_number = Invoke-WebRequest -Uri $vrelease -UseBasicParsing

  $regex = '.exe$'
  $url = $download_page.links | Where-Object href -match $regex | Select-Object -First 6 -expand href

  $versionRegEx = '(\d+)\.(\d+)\.(\d+)\.(\d+)'
  $version = ([regex]::match($version_number.Content, $versionRegEx))

  $url32 = $url[1]
  $url64 = $url[0]
  $surl32 = $url[5]
  $surl64 = $url[4]

  $Latest = @{ URL32 = $url32; URL64 = $url64; SURL32 = $surl32; SURL64 = $surl64; version = $version }
  return $Latest
}

update