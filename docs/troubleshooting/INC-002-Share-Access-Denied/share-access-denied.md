

# INC-002 — Department File Share Access Denied

## Problem

A Sales employee reported being unable to access the departmental file share.

**Affected User:** Ava Robinson (`arobinson`)  
**Resource:** `\\FILE01\Sales`

## Symptoms

The user received an access-denied error when attempting to open the Sales share.

## Investigation

I verified the logged-in user:

```text
whoami
```

I then checked the user's security-group memberships:

```text
whoami /groups
```

The user was correctly assigned to `GG-Sales`.

Connectivity to the file server was tested:

```text
ping FILE01
```

SMB connectivity was also tested:

```text
Test-NetConnection FILE01 -Port 445
```

The server and SMB service were reachable, indicating that the problem was likely related to authorization rather than network connectivity.

I then reviewed the NTFS permissions on the Sales folder on FILE01.

## Root Cause

The `GG-Sales` security group was missing from the NTFS Access Control List for the Sales departmental folder.

Because the user's group did not have the required NTFS permission, access was denied.

## Resolution

`GG-Sales` was restored to the folder's NTFS permissions with Modify access.

Verification

The user reopened:

`\\FILE01\Sales`

and successfully created, edited, and deleted a test file.

## Skills Demonstrated
- SMB troubleshooting
- NTFS permissions
- Active Directory security groups
- Network connectivity testing
- Access-control troubleshooting
- Least-privilege administration