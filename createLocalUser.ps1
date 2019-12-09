
# Function that obtains user account expiry date from the user
function get-expirydate {
    try {
        $expireDate = Get-Date (Read-Host -Prompt 'Enter the expiry date of the account, Ex: 17/07/2017 or 17/07/2017 09:00:00')
        return $expireDate
    }catch {
        return $null
    }
    
}

# Function that starts the creation of a new local user
function create-localuser{

    Write-Output "-----Creating Local User Account: $username -----"
    $username = Read-Host "Enter Username"

    # Check whether username chosen already exists before proceeding
    try {
        $obj = Get-LocalUser -name $username -ErrorAction Stop
        Write-Host "This username, $username already exists."
        # Check whether the user still wish to create an account with another username
        $option = Read-Host "[y] Create another user [Any Other Key] Suspend"
        # If so, execute create-localuser function again
        if ($option -eq "y") {
            create-localuser
        }
    
    # If username does not exists, continue the program
    }catch [Microsoft.PowerShell.Commands.UserNotFoundException]{
        
        Write-Output ""

        # Collect full name details
        $fullname = Read-Host "Enter User Account's Full Name"

        # Check whether account expires - execute the respective command later
        $accountExpires = Read-Host 'Does account expires? [y] Yes [Any other key] No'
        # If account expires, obtain the account expiry date from user
        $expireDate = $null
        if ($accountExpires -eq "y") {
            $expireDate = get-expirydate
            # Check whether user supplies the correct format for expiry date
            while($expireDate -eq $null){
                $expireDate = get-expirydate
            }
        }

        # Check whether user account contains password
        $containsPassword = Read-Host "Does account have password? [y] Yes [Any other key] No"
        # If user account contains password, obtain it from user
        if ($containsPassword -eq "y"){
            $password = Read-Host "Enter password:" -AsSecureString
            # Check whether user account's password expires
            $passwordExpires = Read-Host "Does password expires? [y] Yes [Any other key] No"
        }
        # Check whether user may change password
        $passwordChange = Read-Host "Can the user change their password? [y] Yes [Any Other key] No"

        # Execute respective New-LocalUser command based on user's input
        try {

            # Does not contain password cases

            # Account does not expire, does not contain password, user cannot change their password
            if ($accountExpires -ne "y" -and $containsPassword -ne "y" -and $passwordChange -ne "y"){
                New-LocalUser -Name $username -FullName $fullname -NoPassword -UserMayNotChangePassword
            }
            # Account does not expire, does not contain password, user can change their password
            elseif ($accountExpires -ne "y" -and $containsPassword -ne "y" -and $passwordChange -eq "y") {
                New-LocalUser -Name $username -FullName $fullname -NoPassword
            }
            # Account expires, does not contain password, user cannot change their password
            elseif ($accountExpires -eq "y" -and $containsPassword -ne "y" -and $passwordChange -ne "y") {
                New-LocalUser -Name $username -FullName $fullname -NoPassword -UserMayNotChangePassword -AccountExpires $expireDate
            }
            # Account expires, does not contain password, user can change their password
            elseif ($accountExpires -eq "y" -and $containsPassword -ne "y" -and $passwordChange -eq "y") {
                New-LocalUser -Name $username -FullName $fullname -NoPassword -AccountExpires $expireDate
            }

            # Contain password cases

            # Account expires, contain password, password does not expire, user cannot change their password
            elseif ($accountExpires -eq "y" -and $containsPassword -eq "y" -and $passwordExpires -ne "y" -and $passwordChange -ne "y") {
                New-LocalUser -Name $username -FullName $fullname -Password $password -PasswordNeverExpires -UserMayNotChangePassword -AccountExpires $expireDate
            }
            # Account expires, contain password, password does not expire, user can change their password
            elseif ($accountExpires -eq "y" -and $containsPassword -eq "y" -and $passwordExpires -ne "y" -and $passwordChange -eq "y") {
                New-LocalUser -Name $username -FullName $fullname -Password $password -PasswordNeverExpires -AccountExpires $expireDate
            }
            # Account expires, contain password, password expires, user cannot change their password
            elseif ($accountExpires -eq "y" -and $containsPassword -eq "y" -and $passwordExpires -eq "y" -and $passwordChange -ne "y") {
                New-LocalUser -Name $username -FullName $fullname -Password $password -UserMayNotChangePassword -AccountExpires $expireDate
            }
            # Account expires, contain password, password expires, user can change their password
            elseif ($accountExpires -eq "y" -and $containsPassword -eq "y" -and $passwordExpires -eq "y" -and $passwordChange -eq "y") {
                New-LocalUser -Name $username -FullName $fullname -Password $password -AccountExpires $expireDate
            }
            # Account does not expire, contain password, password does not expire, user cannot change their password
            elseif ($accountExpires -ne "y" -and $containsPassword -eq "y" -and $passwordExpires -ne "y" -and $passwordChange -ne "y") {
                New-LocalUser -Name $username -FullName $fullname -Password $password -PasswordNeverExpires -UserMayNotChangePassword
            }
            # Account does not expire, contain password, password does not expire, user can change their password
            elseif ($accountExpires -ne "y" -and $containsPassword -eq "y" -and $passwordExpires -ne "y" -and $passwordChange -eq "y") {
                New-LocalUser -Name $username -FullName $fullname -Password $password -PasswordNeverExpires
            }
            # Account does not expire, contain password, password expires, user cannot change their password
            elseif ($accountExpires -ne "y" -and $containsPassword -eq "y" -and $passwordExpires -eq "y" -and $passwordChange -ne "y") {
                New-LocalUser -Name $username -FullName $fullname -Password $password -UserMayNotChangePassword
            }
            # Account does not expire, contain password, password expires, user can change their password
            elseif ($uaccountExpires -ne "y" -and $containsPassword -eq "y" -and $passwordExpires -eq "y" -and $passwordChange -eq "y") {
                New-LocalUser -Name $username -FullName $fullname -Password $password
            }

        }
        catch {
            Write-Host "Error Occurred"
        }

    }

}

create-localuser