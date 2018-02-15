# Atom Resource Data Module

## Description

This basic module provides some cmdlets that will assist in gathering data from Azure about your organizations Azure Resources. Currently this is targeted for Virtual Machines.

### Cmdlets

Cmdlets can be viewed like standard PowerShell Modules using the following command:

``` PowerShell
Get-Command -Module AzureResourceData
```

Help may also be viewed using standard methods.

``` PowerShell
Get-Help Get-AzureVMResourceReport -Full
```

### Change Log

#### v0.1.1

* Fixed a bug where the wrong cmdlet was being called to login to Azure.

#### v0.1.0

* Initial release