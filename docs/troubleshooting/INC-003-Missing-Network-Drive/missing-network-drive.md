# INC-003 — Missing Department Network Drive

## Problem

An IT employee reported that the departmental network drive was no longer visible.

**Affected User:** Daniel Kim (`dkim`)  
**Expected Drive:** `I:`  
**Resource:** `\\FILE01\IT`

## Symptoms

The employee could log into PC01, but the IT drive was missing from File Explorer.

The Public drive remained available.

## Investigation

I verified the logged-in account:

```text
whoami
```

I inspected currently mapped network drives:

```text
net use
```

The `I:` mapping was missing.

I then checked the user's security-group memberships:

```text
whoami /groups
```

The user was not a member of `GG-IT`.

I also checked Group Policy application:

```text
gpresult /r
```

The drive-mapping GPO was applying successfully.

The IT mapping, however, uses Group Policy Preferences item-level targeting and only applies when the user belongs to `GG-IT`.

## Root Cause

The employee was missing the `GG-IT` Active Directory security-group membership required by the drive mapping's item-level targeting rule.

## Resolution

The employee was added back to `GG-IT`.

The user signed out and back in to obtain an updated security token.

Group Policy was refreshed:

```text
gpupdate /force
```

## Verification

I verified group membership and checked the mapped drives:

```text
whoami /groups
net use
```

The following mapping was restored:

`I:` → `\\FILE01\IT`

## Skills Demonstrated
- Group Policy Preferences
- Item-level targeting
- Active Directory groups
- Network drive troubleshooting
- gpresult
- Windows security tokens