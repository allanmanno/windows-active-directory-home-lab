# INC-001 — Active Directory Account Lockout

## Problem

A Manno Sales employee reported being unable to sign into a domain workstation after several unsuccessful password attempts.

**Affected User:** Mia Clark (`mclark`)  
**Department:** Sales  
**Affected System:** PC01

## Symptoms

The user was unable to authenticate using her domain account.

Multiple incorrect passwords had been entered before the issue was reported.

## Investigation

I first checked the user's Active Directory account status using PowerShell:

```text
Get-ADUser mclark -Properties LockedOut,Enabled |
Select-Object Name,Enabled,LockedOut
```
I also searched the domain for locked accounts:
```text
Search-ADAccount -LockedOut -UsersOnly
```
The results showed that the account was enabled but locked.

I reviewed the Security log in Windows Event Viewer for account lockout events, including Event ID 4740.

## Root Cause

The user exceeded the domain's configured failed-logon threshold, causing Active Directory to lock the account.

## Resolution

The account was unlocked using:
```test
Unlock-ADAccount -Identity mclark
```

Because the user had forgotten the password, the password was also reset and the account was configured to require a password change at the next logon.

## Verification

I verified the account status:
```text
Get-ADUser mclark -Properties LockedOut |
Select-Object Name,LockedOut
```
`LockedOut` returned `False`.

The user then successfully authenticated to PC01 and changed the temporary password.

## Skills Demonstrated
- Active Directory user administration
- Account lockout troubleshooting
- PowerShell
- Password resets
- Windows Event Viewer
- Verification of issue resolution