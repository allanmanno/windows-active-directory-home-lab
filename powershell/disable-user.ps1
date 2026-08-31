Import-Module ActiveDirectory

$Username = Read-Host "Enter username to disable"

$User = Get-ADUser `
    -Identity $Username `
    -ErrorAction SilentlyContinue

if (-not $User) {

    Write-Host "User not found."

    exit
}

Disable-ADAccount -Identity $Username

Write-Host
Write-Host "$Username has been disabled."

Read-Host "Press Enter to close"