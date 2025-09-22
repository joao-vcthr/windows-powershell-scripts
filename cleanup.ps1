$ErrorActionPreference = "Stop"

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

function Optimize-Disk {
    Write-Host "Optimising disk..." -ForegroundColor Yellow
    Optimize-Volume -DriveLetter 'C' -ReTrim -Verbose
    Write-Host "Optimisation complete!" -ForegroundColor Green
}

function Configure-Network {
    Write-Host "Configuring network and clearing DNS cache..." -ForegroundColor Yellow
    Clear-DnsClientCache
    Restart-NetAdapter -Name "Ethernet"
    netsh winsock reset
    Write-Host "Network configuration complete!" -ForegroundColor Green
}

function main() {
    Write-Host "Running cleanup script..." -ForegroundColor Yellow

    Run-SystemCheck
    Disable-SystemRestore
    Optimize-Disk
    Configure-Network

    Write-Host "Completed! Restarting the computer." -ForegroundColor Green

    Restart-Computer
}

main
