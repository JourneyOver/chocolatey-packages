function Get-GithubRepositoryLicense {
  param (
    [string]$repoUser,
    [string]$repoName
  )

  $apiUrl = "https://api.github.com/repos/$($repoUser)/$($repoName)/license"

  $headers = @{}

  if (Test-Path Env:\github_api_key) {
    $headers.Authorization = 'token ' + $env:github_api_key
  }

  $licenseData = Invoke-RestMethod -Uri $apiUrl -Headers $headers

  return $licenseData
}
