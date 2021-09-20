Import-Module au
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'https://release.tinymediamanager.org/'

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*url(32)?\:\s*).*"        = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum(32)?\:\s*).*"   = "`${1}$($Latest.Checksum32)"
      "(?i)(^\s*checksum\s*type\:\s*).*" = "`${1}$($Latest.ChecksumType32)"
    }
  }
}

function global:au_BeforeUpdate($Package) {
  $licenseFile = "$PSScriptRoot\legal\LICENSE.txt"
  if (Test-Path $licenseFile) { Remove-Item -Force $licenseFile }

  Invoke-WebRequest -UseBasicParsing -Uri $($Package.nuspecXml.package.metadata.licenseUrl -replace 'blob', 'raw') -OutFile $licenseFile
  if (!(Get-ValidOpenSourceLicense -path "$licenseFile")) {
    throw "Unknown license download. Please verify it still contains distribution rights."
  }

  Get-RemoteFiles -Purge -NoSuffix
}

function GetV4Version() {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  #tmm_4.2.2_windows-amd64.zip
  $re = "tmm_4.+_*_windows-amd64.zip$"
  $url = $download_page.links | Where-Object href -Match $re | Select-Object -Last 1 -expand href

  $version = $url -split 'tmm_|_.*_?.zip' | Select-Object -Last 1 -Skip 1
  $url32 = 'https://release.tinymediamanager.org/' + $url

  @{
    Version = $version
    URL32   = $url32
  }
}

function GetV3Version() {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  #tmm_3.1.16.1_win.zip
  $re = "tmm_3.+_*_win.zip$"
  $url = $download_page.links | Where-Object href -Match $re | Select-Object -Last 1 -expand href

  $version = $url -split 'tmm_|_.*_?.zip' | Select-Object -Last 1 -Skip 1
  $url32 = 'https://release.tinymediamanager.org/' + $url

  @{
    Version = $version
    URL32   = $url32
  }
}

function global:au_GetLatest {
  $v3Stream = GetV3Version
  $v4Stream = GetV4Version

  $streams = [ordered] @{
    v3 = $v3Stream
    v4 = $v4Stream
  }

  return @{ Streams = $streams }
}

update -ChecksumFor none
