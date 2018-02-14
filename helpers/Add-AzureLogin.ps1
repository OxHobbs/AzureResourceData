function Add-AzureLogin
{
    [CmdletBinding(SupportsShouldProcess)]

    param 
    (
        [Parameter(Position = 0)]
        [String] $EnvironmentName = 'AzureUSGovernment'
    )

    $context = Get-AzureRmContext
    if (-not $context.Account)
    {
        try 
        {
            $null = Login-AzureRmAccount -EnvironmentName $EnvironmentName -ErrorAction Stop
            return
        }
        catch 
        {
            Write-Error "An error occurred logging into Azure in the environment ($EnvironmentName).  Verify login information is correct"
            Write-Error $error[0].Exception.ToString()    
            break
        }
        
    }
    else
    {
        Write-Verbose "Account already logged in -> $($context.Account)"
        if ($PSCmdlet.ShouldProcess("account id: $($context.Account)?", "Gathering Azure Resources"))
        {
            return
        }
    }
}
