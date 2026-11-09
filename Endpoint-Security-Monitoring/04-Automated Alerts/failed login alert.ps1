$startTime = (Get-Date).AddMinutes(-10)

$reportPath = "$env:USERPROFILE\Documents\Endpoint-Security-Monitoring\04-Automated Alerts\Security-Alerts.txt"

try {
    $events = Get-WinEvent -FilterHashtable @{
        LogName = 'Security'
        Id = 4625
    } -MaxEvents 500 -ErrorAction Stop

    $failedLogins = @($events | Where-Object {
        $_.TimeCreated -ge $startTime
    })

    $count = $failedLogins.Count

    if ($count -ge 5) {
        $message = "$(Get-Date): ALERT! $count failed login attempts detected."
        Write-Host $message -ForegroundColor Red
    }
    else {
        $message = "$(Get-Date): Normal activity. $count failed login attempts detected."
        Write-Host $message -ForegroundColor Green
    }

    Add-Content -Path $reportPath -Value $message
}
catch {
    Write-Host "ERROR: Unable to read Windows Security logs." -ForegroundColor Red
    Write-Host $_.Exception.Message
}