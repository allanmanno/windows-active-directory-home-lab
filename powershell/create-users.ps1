Import-Module ActiveDirectory

$CsvPath = "C:\MannoLab\CSV\new-users.csv"

$Users = Import-Csv $CsvPath

$TemporaryPassword = Read-Host `
    "Enter temporary password for new users" `
    -AsSecureString

foreach ($User in $Users) {

    $OU = "OU=$($User.Department),OU=Users,OU=Manno,DC=manno,DC=local"
    $Group = "GG-$($User.Department)"

    $ExistingUser = Get-ADUser `
        -Filter "SamAccountName -eq '$($User.Username)'" `
        -ErrorAction SilentlyContinue

    if ($ExistingUser) {

        Write-Warning "$($User.Username) already exists. Skipping."

        continue
    }

    New-ADUser `
        -Name "$($User.FirstName) $($User.LastName)" `
        -GivenName $User.FirstName `
        -Surname $User.LastName `
        -SamAccountName $User.Username `
        -UserPrincipalName "$($User.Username)@manno.local" `
        -Department $User.Department `
        -Title $User.Title `
        -Company "Manno" `
        -Path $OU `
        -AccountPassword $TemporaryPassword `
        -Enabled $true `
        -ChangePasswordAtLogon $true

    Add-ADGroupMember `
        -Identity $Group `
        -Members $User.Username

    Write-Host "Created $($User.Username) and added to $Group"
}

Write-Host
Read-Host "Press Enter to close"