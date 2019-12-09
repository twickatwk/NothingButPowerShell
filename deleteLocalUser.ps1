# Obtain list of user accounts for user to select
$username = Get-LocalUser | Select-Object -Property "Name" | Out-GridView -PassThru -Title "Select Local User to Remove"

try {
    # Remove selected user account
    Remove-LocalUser -Name $username.Name -Confirm
    Write-Host "User has been sucessfully removed"
}catch{
    Write-Host "Error in removing selected user account"
}

