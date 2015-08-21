<#
.SYNOPSIS
    Creates a new PowerShell profile.ps1.
.DESCRIPTION
    Creates a new PowerShell profile in specified scope, and can add a script block to the profile.
.INPUTS
    None.
.OUTPUTS
    System.IO.FileInfo.
.PARAMETER Scope
    The scope to create the new profile for.
.PARAMETER ScriptBlock
    A block of code to add to the new profile.
.EXAMPLE
    PS C:\> New-PSProfile
.EXAMPLE
    PS C:\> New-PSProfile -Scope CurrentUserAllHosts -ScriptBlock {Import-Module -Name ActiveDirectory}
.NOTES
    Administrator access is need to create AllUser profile scopes.
.LINK
    http://dotps1.github.io/PSProfile
#>
Function New-PSProfile
{
    [CmdletBinding(ConfirmImpact = 'High',
                   SupportsShouldProcess = $true)]
    [OutputType([System.IO.FileInfo])]

    Param
    (
        [Parameter()]
        [ValidateSet('AllUsersAllHosts','AllUsersCurrentHost','CurrentUserAllHosts','CurrentUserCurrentHost')]
        [String]
        $Scope = 'CurrentUserCurrentHost',

        [Parameter()]
        [ScriptBlock]
        $ScriptBlock
    )

    Begin
    {
        Set-StrictMode -Version 'Latest'
    }

    Process
    {
        $newItemParameters = @{
            Path = $profile.$Scope
            Force = $true
            ErrorAction = 'Stop'
        }

        if ($ScriptBlock)
        {
            $newItemParameters.Add('Value', $ScriptBlock)
        }

        if (Test-Path -Path $profile.$Scope)
        {
            if (-not ($PSCmdlet.ShouldProcess($profile.$Scope, "Overwrite existing profile")))
            {
                break
            }
        }
        
        try
        {
            New-Item @newItemParameters
        }
        catch
        {
            Write-Error -Message $_.ToString()
            break
        }
    }

    End
    {

    }
}