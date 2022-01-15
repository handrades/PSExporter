function New-PromMetricDescription {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string] $Name,
        [Parameter(Mandatory=$true)]
        [ValidateSet('counter','gauge','histogram','summary')]
        [string] $Type,
        [Parameter(Mandatory=$true)]
        [string] $Help,
        [Parameter()]
        [string[]] $Labels
    )
    process{
        [PSCustomObject]@{
            PSTypeName = 'PrometheusMetricDesc'
            Name = $Name
            Type = $Type
            Help = $Help
            Labels = $Labels
        }
    }
}