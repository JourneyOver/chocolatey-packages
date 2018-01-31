$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$Destination = "$toolsDir\tinymediamanager"

Remove-Item $Destination -Recurse -Force
