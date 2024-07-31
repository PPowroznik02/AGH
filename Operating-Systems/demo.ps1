$version = $PSVersionTable.PSVersion
Write-Host "You are running PowerShell $version" -ForegroundColor Red

$name = Read-Host -Prompt "Enter your name"
$greeting = "Hello $name!"

Write-Host $greeting -ForegroundColor Green
