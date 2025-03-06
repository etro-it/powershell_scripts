# This script queries the system event log for restart events within the last month
Get-EventLog -LogName System -After $(Get-Date).AddMonths(-1) | Where {6005, 6006, 6008, 6009 -contains $_.EventID}
