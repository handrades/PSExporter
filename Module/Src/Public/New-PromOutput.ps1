function New-PromOutput {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [PSTypeName('PrometheusMetric')][object[]] $Metrics
    )
    process{
        $Lines = [System.Collections.Generic.List[String]]::new()
        $LastRecord = $null
        foreach ($Metric in $Metrics) {
            if($Metric.Description.name -ne $LastRecord){
                $LastRecord = $Metric.Description.name
                $Lines.Add("# HELP $($Metric.Description.name) $($Metric.Description.help)")
                $Lines.Add("# TYPE $($Metric.Description.name) $($Metric.Description.type)")
            }

            $strBuilder = $null
            if($Metric.Description.labels.count -gt 0){
                for ($i = 0; $i -lt $Metric.Description.labels.Count; $i++) {
                    $strBuilder += "{$($Metric.Description.labels[$i])=`"$($Metric.labels[$i])`"}"
                }
            }
            $Lines.Add("$($Metric.Description.name)$strBuilder $($Metric.type)")
        }
        $Lines -join "`n"
    }
}