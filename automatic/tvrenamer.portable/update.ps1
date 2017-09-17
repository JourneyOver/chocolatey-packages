Import-Module au
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'https://github.com/tvrenamer/tvrenamer/releases/latest'

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

  $regex = '.exe$'
  $url = $download_page.links | Where-Object href -match $regex | ForEach-Object href | Select-Object -First 2

  $version = (Split-Path ( Split-Path $url[0] ) -Leaf).Substring(1)

  $url32 = 'https://github.com' + $url[0]
  $url64 = 'https://github.com' + $url[1]

  $Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
  return $Latest
}

update