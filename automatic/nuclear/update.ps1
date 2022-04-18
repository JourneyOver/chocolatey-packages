Import-Module au
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'https://github.com/nukeop/nuclear/releases'
$repoUser = "nukeop"
$repoName = "nuclear"

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
  $licenseData = Get-GithubRepositoryLicense $repoUser $repoName
  $licenseFile = "$PSScriptRoot\legal\LICENSE.txt"
  if (Test-Path $licenseFile) { Remove-Item -Force $licenseFile }

  Invoke-WebRequest -Uri $licenseData.download_url -UseBasicParsing -OutFile "$licenseFile"
  $Latest.LicenseUrl = $licenseData.html_url

  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_AfterUpdate($Package) {
  Update-Metadata -key "licenseUrl" -value $Latest.LicenseUrl
  Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = 'Setup.+\.exe$'
  $url32 = $download_page.Links | Where-Object href -Match $re | Select-Object -First 1 -expand href | ForEach-Object { 'https://github.com' + $_ }

  $dest = "$env:TEMP\nuclear.exe"

  Invoke-WebRequest -Uri $url32 -OutFile $dest
  $version = (Get-Item $dest).VersionInfo.FileVersion -replace ('\s', '')
  Remove-Item -Force $dest

  $Latest = @{ URL32 = $url32; Version = $version; }
  return $Latest
}

update -ChecksumFor none
