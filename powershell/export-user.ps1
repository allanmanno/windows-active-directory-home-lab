Import-Module ActiveDirectory

$OutputPath = "C:\MannoLab\Reports\Manno-Users.csv"

Get-ADUser -Filter * `
    -SearchBase "OU=Users,OU=Manno,DC=manno,DC=local" `
    -Properties Department,Title,Enabled |
Select-Object Name,
              SamAccountName,
              Department,
              Title,
              Enabled |
Export-Csv -Path $OutputPath -NoTypeInformation

Write-Host "User report created: $OutputPath"

Write-Host
Read-Host "Press Enter to close"