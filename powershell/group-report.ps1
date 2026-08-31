Import-Module ActiveDirectory

$Groups = Get-ADGroup -Filter 'Name -like "GG-*"'

$Results = foreach ($Group in $Groups) {

    $Members = Get-ADGroupMember -Identity $Group.Name

    foreach ($Member in $Members) {

        [PSCustomObject]@{
            Group    = $Group.Name
            Name     = $Member.Name
            Username = $Member.SamAccountName
        }
    }
}

$Results |
Sort-Object Group,Name |
Export-Csv `
    "C:\MannoLab\Reports\Group-Membership.csv" `
    -NoTypeInformation

Write-Host "Group membership report created."

Write-Host
Read-Host "Press Enter to close"