
function Receive-Output
{
    process { write-host $_ -ForegroundColor Green}
}

$name = Read-Host "What is your name?"
Write-Output "$name"