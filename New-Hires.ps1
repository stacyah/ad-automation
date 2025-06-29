# import active directory module
Import-Module ActiveDirectory

$csvPath = "C:\Users\Administrator\Documents\new_users.csv"
$ouPath = "OU=CorpUsers,DC=corp,DC=net"
$usersToCreate = Import-Csv -Path $csvPath

# loop through csv and create users
foreach ($user in $usersToCreate) {
    $firstName  = $user.FirstName
    $lastName   = $user.LastName
    $department = $user.Department
    $jobTitle   = $user.JobTitle
    $username = "$($firstName.Substring(0,1))$lastName".ToLower()
    $defaultPassword = "Password123!" | ConvertTo-SecureString -asPlainText -Force

    New-ADUser -Name "$firstName $lastName" `
        -GivenName $firstName `
        -Surname $lastName `
        -SamAccountName $username `
        -UserPrincipalName "$username@corp.net" `
        -Path $ouPath `
        -Department $department `
        -Title $jobTitle `
        -AccountPassword $defaultPassword `
        -Enabled $true `
        -ChangePasswordAtLogon $true

    Write-Host "created user: $username"
}