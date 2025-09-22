

$ErrorActionPreference = "Stop"

function Configure-PowerPlan {
    Write-Host "Configuring power plan..." -ForegroundColor Yellow
    Write-Host "Changing powerplan to High Performance" -ForegroundColor Yellow
    powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

    powercfg /change monitor-timeout-ac 5
    powercfg /change disk-timeout-ac 0
    powercfg /change standby-timeout-ac 0

    powercfg /setacvalueindex SCHEME_CURRENT 02f815b5-a5cf-4c84-bf20-649d1f75d3d8 4c793e7d-a264-42e1-87d3-7a0d2f523ccd 000
    powercfg /setacvalueindex SCHEME_CURRENT 0d7dbae2-4294-402a-ba8e-26777e8488cd 309dce9b-bef4-4119-9921-a851fb12f0f4 001
    powercfg /setacvalueindex SCHEME_CURRENT 19cbb8fa-5279-450e-9fac-8a3d5fedd0c1 12bbebe6-58d6-4636-95bb-3217ef867c1a 003
    powercfg /setacvalueindex SCHEME_CURRENT SUB_SLEEP RTCWAKE 000
    powercfg /setacvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 000
    powercfg /setacvalueindex SCHEME_CURRENT SUB_PCIEXPRESS ASPM 001

    powercfg.exe /hibernate off

    Write-Host "Power plan configured!" -ForegroundColor Green
}

function Set-SystemClock {
    Write-Host "Setting time zone to Brasília..." -ForegroundColor Yellow
    Set-TimeZone -Id "E. South America Standard Time"
    Write-Host "Time zone set successfully!" -ForegroundColor Green
    Write-Host "Synchronising clock..." -ForegroundColor Yellow
    net start w32time
    W32tm /resync /force
    Write-Host "Clock synchronised successfully!" -ForegroundColor Green
}

function Run-SystemCheck {
    Write-Host "Starting disk and Windows image checkup..." -ForegroundColor Yellow
    DISM /Online /Cleanup-Image /RestoreHealth
    sfc /scannow
    "Y" | chkdsk C: /f
    Write-Host "Checkup complete!" -ForegroundColor Green
}

function Disable-SystemRestore {
    Disable-ComputerRestore -Drive "C:\"
    Write-Host "System Restore has been disabled!" -ForegroundColor Green
    vssadmin delete shadows /all /quiet
    Write-Host "Restore points deleted!" -ForegroundColor Green
}

function Disable-SysMain {
    Write-Host "Disabling SysMain..." -ForegroundColor Yellow
    Stop-Service -Name "SysMain" -Force
    Write-Host "SysMain has been disabled!" -ForegroundColor Green
    Set-Service -Name "SysMain" -StartupType Disabled
    Write-Host "SysMain automatic startup has been disabled!" -ForegroundColor Green
}

function Optimize-Disk {
    Write-Host "Optimising disk..." -ForegroundColor Yellow
    Optimize-Volume -DriveLetter 'C' -ReTrim -Verbose
    Write-Host "Optimisation complete!" -ForegroundColor Green
}

function Configure-Network {
    Write-Host "Configuring network and clearing DNS cache..." -ForegroundColor Yellow
    Clear-DnsClientCache
    Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses ("9.9.9.9", "149.112.112.112")
    Restart-NetAdapter -Name "Ethernet"
    netsh winsock reset
    Write-Host "Network configuration complete!" -ForegroundColor Green
}

function main() {
    Write-Host "Setting up system" -ForegroundColor Yellow

    Configure-PowerPlan
    Set-SystemClock
    Run-SystemCheck
    Disable-SystemRestore
    Disable-SysMain
    Optimize-Disk
    Configure-Network

    Write-Host "Done! Restarting the computer..." -ForegroundColor Green

    Restart-Computer
}

main
