function Get-Message{
    Param(
        [Parameter(Mandatory= $true, HelpMessage="Enter a message!")]
        [ValidateNotNullOrEmpty()]
        [string] $Message
    )
    $Message
}

Get-Message