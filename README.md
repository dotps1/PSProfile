#PSProfile PowerShell Module

This is an experimental PowerShell Module for creating, deleting and manipulating the different profile.ps1's that the PowerShell host(s) use.

###Examples
```PowerShell
# Create a new profile, set it to auto load the AD Module.
New-PSProfile -Scope CurrentUserAllHosts -ScriptBlock {Import-Module -Name ActiveDirectory}
```

```PowerShell
# Copy your profile to other locations.
Copy-PSProfile -Scope CurrentUserAllHosts -Destination $profile.AllUsersAllHosts
```