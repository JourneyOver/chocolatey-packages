Import-Module au
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'https://github.com/Jackett/Jackett/releases'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "([$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "([$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "([$]version\s*=\s*)('.*')"  = "`$1'$($Latest.Version)'"
    }
  }
}

function global:au_AfterUpdate {
  Set-DescriptionFromReadme -SkipFirst 1
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $regex = '.exe$'
  $url = $download_page.links | Where-Object href -match $regex | ForEach-Object href | Select-Object -First 1

  $version = (Split-Path ( Split-Path $url ) -Leaf).Substring(1)

  $url32 = 'https://github.com' + $url

  $Latest = @{ URL32 = $url32; Version = $version }
  return $Latest
}

update -ChecksumFor 32