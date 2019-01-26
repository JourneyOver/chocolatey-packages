$ErrorActionPreference = 'Stop'

$packageName = 'memreduct'

Remove-Item "$env:ProgramFiles\Mem Reduct" -Force -Recurse -ErrorAction 'SilentlyContinue'
