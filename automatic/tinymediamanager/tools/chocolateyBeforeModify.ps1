$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$Destination = "$toolsDir\tmm"

Remove-Item $Destination -Recurse -Force
