Import-Module ActiveDirectory

$Username = Read-Host "Enter username to enable"

$User = Get-ADUser `
    -Identity $Username `
    -ErrorAction SilentlyContinue

if (-not $User) {

    Write-Host "User not found."

    exit
}

Enable-ADAccount -Identity $Username

Write-Host "$Username has been enabled."

Write-Host
Read-Host "Press Enter to close"