Import-Module ActiveDirectory

$Username = Read-Host "Enter username"

$User = Get-ADUser `
    -Identity $Username `
    -Properties LockedOut `
    -ErrorAction SilentlyContinue

if (-not $User) {

    Write-Host "User not found."

    exit
}

if ($User.LockedOut) {

    Unlock-ADAccount -Identity $Username

    Write-Host "$Username has been unlocked."

}
else {

    Write-Host "$Username is not currently locked."
}

Write-Host
Read-Host "Press Enter to close"