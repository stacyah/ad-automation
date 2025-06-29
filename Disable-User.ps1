# accept username as an argument
param (
    [Parameter(Mandatory=$true)]
    [string]$Username
)

Import-Module ActiveDirectory

$disabledOUPath = "OU=DisabledUsers,DC=corp,DC=net"
$user = Get-ADUser -Identity $Username

if ($user) {
    Disable-ADAccount -Identity $user
    Write-Host "disabled account: $Username"

    Move-ADObject -Identity $user.DistinguishedName -TargetPath $disabledOUPath
    Write-Host "moved $Username to DisabledUsers OU"
} else {
    Write-Host "error: user '$Username' not found"
}