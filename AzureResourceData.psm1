
$moduleRoot = Split-Path -Path $MyInvocation.MyCommand.Path

"$moduleRoot\helpers\*.ps1", "$moduleRoot\Functions\*.ps1" | Resolve-Path | Where-Object { -not ($_.ProviderPath.ToLower().Contains(".tests.")) } |
	ForEach-Object { . $_.ProviderPath }

