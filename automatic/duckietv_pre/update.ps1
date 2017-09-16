Import-Module au
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'https://github.com/DuckieTV/Nightlies/releases'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "([$]url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
      "([$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
      "([$]checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
      "([$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
    }
  }
}

function global:au_AfterUpdate {
  Set-DescriptionFromReadme -SkipFirst 1
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $regex = 'x(\d+).zip$'
  $url = $download_page.links | Where-Object href -match $regex | ForEach-Object href | Select-Object -First 2

  $bversion = $url[0] -split 'nightly-|/' | Select-Object -Last 1 -Skip 1
  $version = $bversion -replace '(....(?!$))', '$1.'
  $build = '-nightly'

  $url32 = 'https://github.com' + $url[0]
  $url64 = 'https://github.com' + $url[1]

  $Latest = @{ PackageName = 'duckietv'; URL32 = $url32; URL64 = $url64; Version = ($version + $build)}
  return $Latest
}

update -ChecksumFor none