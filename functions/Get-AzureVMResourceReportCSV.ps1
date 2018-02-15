<#
.SYNOPSIS
Output a CSV report of information returned from the Get-AzureVMResourceReport cmdlet.

.DESCRIPTION
This cmdlet will output a report of information returned from the Get-AzureVMResourceReport cmdlet.  This will default to the user's desktop.

.PARAMETER Path
The Path, including filename, of the desired location to store the CSV.

.EXAMPLE
This command will gather information about your VMs from your Azure subscriptions and convert it to a CSV at c:\Report.csv.

Get-AzureVMResourceReportCSV -Path c:\Report.csv

.EXAMPLE
This command will gather information about VMs from your Azure subscriptions and convert it to a CSV stored on the users desktop.

Get-AzureVMResourceReportCSV
#>
function Get-AzureVMResourceReportCSV
{
    [CmdletBinding()]

    param
    (
        [Parameter()]
        [String] $Path = "$env:USERPROFILE\Desktop\AzureVMResourceReport-$(get-date -Format 'yyyy_MM_dd').csv"
    )

    $res = Get-AzureVmResourceReport
    $res | ConvertTo-Csv -NoTypeInformation | Out-File -FilePath $Path -Force
}
