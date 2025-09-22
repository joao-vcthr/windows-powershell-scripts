

$ErrorActionPreference = "Stop"

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

function Disable-GameDVR {
    # Define the registry keys and values
    $registryPath = "HKCU:\\System\\GameConfigStore"

    $changes = @(
        @{ Name = "GameDVR_FSEBehavior"; Value = 2 },
        @{ Name = "GameDVR_Enabled"; Value = 0 },
        @{ Name = "GameDVR_HonorUserFSEBehaviorMode"; Value = 1 },
        @{ Name = "GameDVR_EFSEFeatureFlags"; Value = 0 }
    )

# Update keys in the main path
foreach ($change in $changes) {
    Write-Host "Changing $($change.Name) to $($change.Value)" -ForegroundColor Yellow
    Set-ItemProperty -Path $registryPath -Name $change.Name -Value $change.Value -Force
    }

    # Update the AllowGameDVR key in another path
    $allowGameDVRPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR"
    if (-not (Test-Path $allowGameDVRPath)) {
        Write-Host "Creating key: $allowGameDVRPath" -ForegroundColor Yellow
        New-Item -Path $allowGameDVRPath -Force | Out-Null
        }

        Write-Host "Changing AllowGameDVR to 0" -ForegroundColor Yellow
        Set-ItemProperty -Path $allowGameDVRPath -Name "AllowGameDVR" -Value 0 -Force

        Write-Host "GameDVR has been disabled" -ForegroundColor Green
    }

function Disable-Services {
    # List of services to be disabled
    $services = @(
        "WSearch",          # Windows Search
        "Spooler",          # Print Spooler
        "Fax",              # Fax
        "WerSvc",           # Windows Error Reporting
        "RemoteRegistry",   # Remote Registry
        "TermService",      # Remote Desktop Services
        "TabletInputService", # Touch Keyboard & Handwriting
        "seclogon",         # Secondary Logon
        "SCardSvr",         # Smart Card
        "SCPolicySvc",      # Smart Card Policy
        "WbioSrvc",         # Windows Biometric Service
        "MapsBroker",       # Downloaded Maps Manager
        "CscService",       # Offline Files
        "RasMan",           # Remote Access Connection Manager
        "RemoteAccess",     # Routing and Remote Access
        "RetailDemo",       # Retail Demo Service
        "diagnosticshub.standardcollector.service", # Diagnostics Hub
        "DiagTrack",        # Connected User Experiences & Telemetry
        "dmwappushservice"  # Device Management Wireless Application Protocol
    )

foreach ($s in $services) {
    Write-Host "Disabling service: $s"
    Stop-Service -Name $s -Force -ErrorAction SilentlyContinue
    Set-Service -Name $s -StartupType Disabled -ErrorAction SilentlyContinue
    }
}

function main {
    Write-Host "Starting final setup script..." -ForegroundColor Yellow

    Disable-SystemRestore
    Disable-GameDVR
    Disable-Services
    Optimize-Disk

    Write-Host "Script completed! Restarting the computer" -ForegroundColor Green

    Restart-Computer
}

main
