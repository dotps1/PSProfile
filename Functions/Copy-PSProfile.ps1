<#
.SYNOPSIS
    Copys a PowerShell profile to another location.
.DESCRIPTION
    Copys the PowerShell profile of a specific scope to another location.
.INPUTS
    None.
.OUTPUTS
    System.IO.FileInfo.
.PARAMETER Scope
    The scope to copy.
.PARAMETER Destination
    The destination to copy the profile.
.EXAMPLE
    PS C:\> Copy-PSProfile
.EXAMPLE
    PS C:\> Copy-PSProfile -Scope AllUsersAllHosts -Destination "$env:USERPROFILE\Desktop"
.LINK
    http://dotps1.github.io/PSProfile
#>
Function Copy-PSProfile
{
    [OutputType([System.IO.FileInfo])]

    Param
    (
        [Parameter()]
        [ValidateSet('AllUsersAllHosts','AllUsersCurrentHost','CurrentUserAllHosts','CurrentUserCurrentHost')]
        [String]
        $Scope = 'CurrentUserCurrentHost',

        [Parameter()]
        [String]
        $Destination = $PWD
    )

    Begin
    {
        Set-StrictMode -Version 'Latest'
    }
    
    Process
    {
        if (Test-Path -Path $profile.$Scope)
        {
            try
            {
                Copy-Item -Path $profile.$Scope -Destination $Destination -PassThru -ErrorAction 'Stop'
            }
            catch
            {
                Write-Error -Message $_.ToString()
                break
            }
        }
        else
        {
            Write-Error -Message "Cannot find path '$($profile.$Scope)' because it does not exist."
            break
        }
    }

    End
    {
    
    }
}