<#
.SYNOPSIS
    Removes a PowerShell profile.
.DESCRIPTION
    Removes a PowerShell profile of the specified scope.
.INPUTS
    None.
.OUTPUTS
    None.
.PARAMETER Scope
    The PowerShell profile to be removed.
.EXAMPLE
    PS C:\> Remove-PSProfile
.EXAMPLE
    PS C:\> Remove-PSProfile -Scope CurrentUserCurrentHost
.NOTES
    Administrative access is need to remove AllUser profiles.
.LINK
    http://dotps1.github.io
#>
Function Remove-PSProfile
{
    [CmdletBinding(ConfirmImpact = 'High',
                   SupportsShouldProcess = $true)]

    Param
    (
        [Parameter()]
        [ValidateSet('AllUsersAllHosts','AllUsersCurrentHost','CurrentUserAllHosts','CurrentUserCurrentHost')]
        [String]
        $Scope = 'CurrentUserCurrentHost'
    )

    Begin
    {
        Set-StrictMode -Version 'Latest'
    }

    Process
    {
        if ($PSCmdlet.ShouldProcess($profile.$Scope, 'Remove profile'))
        {
            try
            {
                Remove-Item -Path $profile.$Scope -Force
            }
            catch
            {
                Write-Error -Message $_.ToString()
            }
        }
    }

    End
    {
    
    }
}