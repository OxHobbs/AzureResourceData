<#
.SYNOPSIS
Return an object with information about VMs running in an Azure environment.

.DESCRIPTION
Return an object that has information about VMs running in an Azure environment.  This cmdlet currently has no parameters.

.EXAMPLE
Get-AzureVMResourceReport
#>
function Get-AzureVMResourceReport
{
    [CmdletBinding()]

    param()

    Add-AzureLogin -Confirm

    $retObs = @()
    $subs = Get-AzureRmSubscription

    foreach ($sub in $subs)
    {
        $subName = if ($sub.SubscriptonName) { $sub.SubscriptionName } else { $sub.Name }
        Write-Verbose "Looking to the subscription named: $subName -> $($sub.SubscriptionId)"

        $subId = if ($sub.SubscriptionId) { $sub.SubscriptionId } else { $sub.Id }
        $null = Select-AzureRmSubscription -SubscriptionId $subId
        $vms = Get-AzureRmVM

        foreach ($vm in $vms)
        {
            Write-Verbose "Gathering information on $($vm.Name)"
            $status = (Get-AzureRmVM -Status -ResourceGroupName $vm.ResourceGroupName -Name $vm.Name).Statuses[1].DisplayStatus
            $os = $vm.StorageProfile.OsDisk.OsType
            $size = $vm.HardwareProfile.VmSize
            $prof = Get-AzureRmVMSize -Location $vm.Location | Where-Object name -eq $vm.HardwareProfile.VmSize
            $ramInGB = $prof.MemoryInMB / 1024
            $coreCount = $prof.NumberOfCores
            $osGB = if ($vm.StorageProfile.OsDisk.DiskSizeGB)
            {
                $vm.StorageProfile.OsDisk.DiskSizeGB
            }
            else
            {
                $prof.OSDiskSizeInMB / 1024
            }

            $dataGB = Get-DataGB -DataDisks $vm.StorageProfile.DataDisks

            $props = [Ordered] @{
                SubscriptionName = $subName
                ResourceGroup = $vm.ResourceGroupName
                VMName = $vm.Name
                OSType = $os
                VMSize = $size
                CoreCount = $coreCount
                VMStatus = $status
                RAM = $ramInGB
                OSDiskGB = $osGB
                DataDiskGB = $dataGB
                NumOfDataDisks = $vm.StorageProfile.DataDisks.Count
            }

            $retObs += New-Object -TypeName PSObject -Property $props
        }
    }
    $retObs
}
