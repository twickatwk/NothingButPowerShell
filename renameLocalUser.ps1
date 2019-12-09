# Obtain list of user accounts for user to select
$username = Get-LocalUser | Select-Object -Property "Name" | Out-GridView -PassThru -Title "Select Local User to Remove"

function get-newusername(){
    $newUsername = Read-Host "Enter New Username"
    try {
        $obj = Get-LocalUser -name $newUsername -ErrorAction Stop
        return $false
    }catch [Microsoft.PowerShell.Commands.UserNotFoundException]{
        return $newUsername
    }
}

# If so, execute create-localuser function again
$newUsername = get-newusername

while($newUsername -eq $false) {
    Write-Host "This username, $newUsername already exists. Please kindly provide another username"
    $newUsername = get-newusername
}

try{
    # Rename selected user account
    Rename-LocalUser -Name $username.Name -NewName $newUsername -Confirm
    Write-Host "User account has been successfully renamed."
}catch {
    Write-Host "Error in renaming user account."
}
         