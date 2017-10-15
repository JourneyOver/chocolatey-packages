Import-Module au

$releases = 'http://www.carifred.com/quick_any2ico/'

function global:au_BeforeUpdate {
  if (!(Test-Path ".\tools" -PathType Container)) { New-Item -ItemType Directory ".\tools" }
}

function global:au_SearchReplace {
  @{
    ".\any2ico.nuspec" = @{
      "(\<dependency .+? version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $regex = '.exe$'
  $url = $download_page.links | Where-Object href -match $regex | Select-Object -First 1 -expand href

  $versionRegEx = '(\d+)\.(\d+)\.(\d+)\.(\d+)'
  $version = ([regex]::match($download_page.Content, $versionRegEx))

  $url32 = $releases + $url

  $Latest = @{ PackageName = 'any2ico'; URL32 = $url32; Version = $version }
  return $Latest
}

update -NoCheckUrl -ChecksumFor none
