Import-Module au
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releasev3 = 'https://release.tinymediamanager.org/download_v3.html'
$releasev4 = 'https://release.tinymediamanager.org/download_v4.html'
$releasev5 = 'https://release.tinymediamanager.org/download_v5.html'

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

  if ($Latest.URL32 -like '*tmm_3*' -or $Latest.URL32 -like '*tmm_4*') {
    Copy-Item "$PSScriptRoot\version_switch\old_versions.ps1" "$PSScriptRoot\tools\chocolateyInstall.ps1" -Force
  } else {
    Copy-Item "$PSScriptRoot\version_switch\version5.ps1" "$PSScriptRoot\tools\chocolateyInstall.ps1" -Force
  }
}

function global:au_AfterUpdate {
  . "$PSScriptRoot/update_helper.ps1"
  if ($Latest.URL32 -like '*tmm_3*') {
    addDependency ".\*.nuspec" 'jre8' '8.0.171'
  } else {
    removeDependencies ".\*.nuspec"
  }
}

function GetV5Version() {
  $download_page = Invoke-WebRequest -Uri $releasev5 -UseBasicParsing

  #tinyMediaManager-5.0.1.1-windows-amd64.zip
  $re = "tinyMediaManager-5.+_*-windows-amd64.zip$"
  $url = $download_page.links | Where-Object href -Match $re | Select-Object -Last 1 -expand href

  $version = $url -split 'tinyMediaManager-|-.*?.zip' | Select-Object -Last 1 -Skip 1
  $url32 = 'https://release.tinymediamanager.org/' + $url

  @{
    Version = $version
    URL32   = $url32
  }
}

function GetV4Version() {
  $download_page = Invoke-WebRequest -Uri $releasev4 -UseBasicParsing

  #tmm_4.2.2_windows-amd64.zip
  $re = "tmm_4.+_*_windows-amd64.zip$"
  $url = $download_page.links | Where-Object href -Match $re | Select-Object -Last 1 -expand href

  $version = $url -split 'tmm_|_.*?.zip' | Select-Object -Last 1 -Skip 1
  $url32 = 'https://release.tinymediamanager.org/' + $url

  @{
    Version = $version
    URL32   = $url32
  }
}

function GetV3Version() {
  $download_page = Invoke-WebRequest -Uri $releasev3 -UseBasicParsing

  #tmm_3.1.17_win.zip
  $re = "tmm_3.+_*_win.zip$"
  $url = $download_page.links | Where-Object href -Match $re | Select-Object -Last 1 -expand href

  $version = $url -split 'tmm_|_.*?.zip' | Select-Object -Last 1 -Skip 1
  $url32 = 'https://release.tinymediamanager.org/' + $url

  @{
    Version = $version
    URL32   = $url32
  }
}

function global:au_GetLatest {
  $v3Stream = GetV3Version
  $v4Stream = GetV4Version
  $v5Stream = GetV5Version

  $streams = [ordered] @{
    v3 = $v3Stream
    v4 = $v4Stream
    v5 = $v5Stream
  }

  return @{ Streams = $streams }
}

update -ChecksumFor none
