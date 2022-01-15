# define a metric description
$ping_latency = New-PromMetricDescription -Name 'pwsh_ping_latency' -Type gauge -Help 'current ping latency' -Labels 'hostname'

# Define nodes to ping
$node = echo 1.1.1.1

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
$metric = New-PromMetric -MetricDesc $ping_latency -Value $latency -Labels $node

# output strings in Prometheus format
New-PromOutput -Metrics $metric
