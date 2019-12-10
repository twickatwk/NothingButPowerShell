$option = "Add a Local User", "Rename Local User","Delete a Local User" | Out-GridView -PassThru -Title "Local User Management System"

if ($option -eq "Add a Local User"){
    . ".\createLocalUser.ps1"
}elseif ($option -eq "Delete a Local User") {
    . ".\deleteLocalUser.ps1"
}elseif ($option -eq "Rename Local User") {
    . ".\renameLocalUser.ps1"
}
