function New-PromMetric {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [PSTypeName('PrometheusMetricDesc')] $MetricDesc,
        [Parameter(Mandatory=$true)]
        [float] $Value,
        [string[]] $Labels
    )
    begin{
        if (-not($MetricDesc.Labels.count -eq $Labels.Count)){
            throw "There are $($MetricDesc.Labels.count) labels set on New-PromMetricDescription but only $($Labels.Count) set here."
        }
    }
    process{
        [PSCustomObject]@{
            PSTypeName = 'PrometheusMetric'
            Description = $MetricDesc
            Type = $Value
            Labels = $Labels
        }
    }
}