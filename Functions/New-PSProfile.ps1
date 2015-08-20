<#
.SYNOPSIS
    Creates a new profile.ps1.
.DESCRIPTION
    Creates a new profile in specified scope, and can add a script block to the profile.
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
    Administrator access is need to creat AllUser profile scopes.
.LINK
    http://dotps1.github.io
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
        if ($PSCmdlet.ShouldProcess($profile.$Scope, 'Overwrite current profile'))
        {
            $newItemParameters = @{
                Path = $profile.$Scope
                Force = $true
            }

            if ($ScriptBlock)
            {
                $newItemParameters.Add('Value', $ScriptBlock)
            }

            try
            {
                New-Item @newItemParameters
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