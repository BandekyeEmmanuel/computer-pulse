# -----------------------------------------
# COMPUTER PULSE - SYSTEM DIAGNOSTIC AGENT (POWERSHELL)
# -----------------------------------------

$LogFile = "data\system_init.log"

Write-Host "[PROCESSING] Gathering system statistics..." -ForegroundColor Cyan

# INPUT: Query system information
$os = Get-CimInstance -ClassName Win32_OperatingSystem
$cpu = Get-CimInstance -ClassName Win32_Processor
$memFree = [math]::Round($os.FreePhysicalMemory / 1024, 2)
$memTotal = [math]::Round($os.TotalVisibleMemorySize / 1024, 2)

# PROCESSING: Prepare output
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$report = @"
===== COMPUTER PULSE DIAGNOSTIC LOG =====
Timestamp: $timestamp
OS: $($os.Caption)
Version: $($os.Version)
CPU: $($cpu.Name)
Total Memory (MB): $memTotal
Free Memory (MB): $memFree
User: $env:USERNAME
Computer: $env:COMPUTERNAME

"@

# OUTPUT: Save to log
$report | Out-File -FilePath $LogFile -Encoding utf8

Write-Host "[SUCCESS] Diagnostic log saved to $LogFile" -ForegroundColor Green
Write-Host $report