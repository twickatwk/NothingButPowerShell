$option = "Add a Local User", "Delete a Local User" | Out-GridView -PassThru -Title "Local User Management System"

if ($option -eq "Add a Local User"){
    . ".\createLocalUser.ps1"
}elseif ($option -eq "Delete a Local User") {
    Write-Host "Deleting a Local User"
}
