# Export all the extensions that are meant to be used
# within a au update script here.

# We just specify the functions we want to export
# but the file containing the functions is expected
# to be named using the same name.
$funcs = @(
  'Update-Metadata'
  'Get-LatestGithubReleases'
  'Get-AllGithubReleases'
  'Get-ValidOpenSourceLicense'
  "Get-GithubRepositoryLicense"
)

$funcs | % {
  if (Test-Path "$PSScriptRoot\$_.ps1") {
    . "$PSScriptRoot\$_.ps1"
    if (Get-Command $_ -ea 0) {
      Export-ModuleMember -Function $_
    }
  }
}
