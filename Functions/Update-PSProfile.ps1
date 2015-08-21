<#
.SYNOPSIS
    Adds a script block to a PowerShell profile.
.DESCRIPTION
    Adds a block of code to be added to a PowerShell profile of the specified scope.
    This will be executed everytime the host is launched that uses the scoped profile.
.INPUTS
    None.
.OUTPUTS
    System.IO.FileInfo.
.PARAMETER Scope
    The profile to add code to.
.PARAMETER ScriptBlock
    The code to be added to the profile.
.EXAMPLE
    PS C:\> Update-PSProfile -ScriptBlock {Import-Module -Name ActiveDirectory}
.EXAMPLE
    PS C:\> Update-PSProfile -Scope AllUsersAllHosts -ScriptBlock {Import-Module -Name ActiveDirectory}
.NOTES
    Administrive rights are needed to update AllUser profiles.
.LINK
    http://dotps1.github.io/PSProfile
#>
Function Update-PSProfile
{
    [CmdletBinding()]
    [OutputType([System.IO.FileInfo])]

    Param
    (
        [Parameter()]
        [ValidateSet('AllUsersAllHosts','AllUsersCurrentHost','CurrentUserAllHosts','CurrentUserCurrentHost')]
        [String]
        $Scope = 'CurrentUserCurrentHost',

        [Parameter(Mandatory = $true)]
        [ScriptBlock]
        $ScriptBlock
    )

    Begin
    {
        Set-StrictMode -Version 'Latest'
    }

    Process
    {
        if(-not (Test-Path -Path $profile.$Scope))
        {
            New-PSProfile -Scope $Scope -ScriptBlock $ScriptBlock
        }
        else
        {
        try
            {
                Add-Content -Path $profile.$Scope -Value "`r`n$ScriptBlock"
            }
            catch
            {
                Write-Error -Message $_.ToString()
            }
        }
    }
}