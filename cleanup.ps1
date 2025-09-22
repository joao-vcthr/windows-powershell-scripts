<#
.SYNOPSIS
    Performs routine system cleanup and maintenance tasks.

.DESCRIPTION
    This script is designed to be run periodically to maintain system health.
    Tasks include:
    - System file check and repair (DISM, SFC, CHKDSK).
    - Disabling and cleaning up System Restore.
    - Optimization of the main disk.
    - DNS cache clearing and network component reset.
    The computer will be restarted upon completion to finish the CHKDSK process.

.NOTES
    Author:      joao-vcthr
    Date:        09/21/2025
    Requirements: Must be run as Administrator.
#>

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
