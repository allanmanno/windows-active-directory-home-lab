Import-Module ActiveDirectory

$Users = Get-ADUser -Filter *
$Groups = Get-ADGroup -Filter *
$Computers = Get-ADComputer -Filter *
$LockedUsers = Search-ADAccount -LockedOut -UsersOnly
$DisabledUsers = Search-ADAccount -AccountDisabled -UsersOnly

Write-Host "=== MANNO ACTIVE DIRECTORY SUMMARY ==="
Write-Host ""
Write-Host "Users:            $($Users.Count)"
Write-Host "Groups:           $($Groups.Count)"
Write-Host "Computers:        $($Computers.Count)"
Write-Host "Locked Accounts:  $($LockedUsers.Count)"
Write-Host "Disabled Accounts:$($DisabledUsers.Count)"

Write-Host
Read-Host "Press Enter to close"