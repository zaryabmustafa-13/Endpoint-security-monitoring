$baselinePath = "$env:USERPROFILE\Documents\Endpoint-Security-Monitoring\02-File-Integrity-Monitoring\baseline.csv"

$filePath = "$env:USERPROFILE\Documents\SecurityLab\sysmon-check.txt"

$baseline = Import-Csv $baselinePath
$current = Get-FileHash $filePath -Algorithm SHA256

if ($baseline.Hash -eq $current.Hash) {
    Write-Host "File is safe. No changes detected." -ForegroundColor Green
}
else {
    Write-Host "ALERT! File has been modified." -ForegroundColor Red
}