Import-Module au
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$release = 'https://release.tinymediamanager.org/download_v5.html'

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

function global:au_AfterUpdate($Package) {
  Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $release -UseBasicParsing

  #tinyMediaManager-5.0.1.1-windows-amd64.zip
  $re = "tinyMediaManager-5.+_*-windows-amd64.zip$"
  $url = $download_page.links | Where-Object href -Match $re | Select-Object -Last 1 -expand href

  $version = $url -split 'tinyMediaManager-|-.*?.zip' | Select-Object -Last 1 -Skip 1
  $url32 = 'https://release.tinymediamanager.org/' + $url

  $Latest = @{ URL32 = $url32; Version = $version }
  return $Latest
}

update -ChecksumFor none
