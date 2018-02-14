function Get-DataGB
{
    param
    (
        [Parameter()]
        [Object] $DataDisks
    )

    $total = 0

    if (-not $DataDisks)
    {
        return $total
    }
    
    foreach ($disk in $DataDisks)
    {
        $total += $disk.DiskSizeGB
    }
    return $total
}