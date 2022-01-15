$ping_latency = New-PromMetricDescription -Name 'pwsh_ping_latency' -Type gauge -Help 'current ping latency' -Labels 'hostname'

# Define nodes to ping
$nodes = echo 8.8.8.8 1.1.1.1 192.168.1.1 127.0.0.1 1.2.3.4

# Ping each node
$results = foreach ($node in $nodes) {
    # Store ping result to variable
    $result = Test-Connection -ComputerName $node -Count 1 -ErrorAction SilentlyContinue

    # Set latency to variable. If the node does not respond or there is an error value will be -1
    if ($result.Status -eq 'success') {
        $latency = $result.latency
    } else {
        $latency = -1
    }

    # If you are using PowerShell version 7 or greater you can use ternary operator and replace the if above with the following code.
    # Just uncomment the line below and delete the if above
    # $latency = ($result.Status -eq 'success') ? ($result.latency) : -1

    # set values to metric description
    New-PromMetric -MetricDesc $ping_latency -Value $latency -Labels $node
}

New-PromOutput -Metrics $results