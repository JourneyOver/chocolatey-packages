$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$Destination = "$toolsDir\mpc-qt"

Remove-Item $Destination -Recurse -Force
