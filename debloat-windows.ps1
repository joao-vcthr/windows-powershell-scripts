<#
.SYNOPSIS
    Removes bloatware, pre-installed apps, and optional Windows features.

.DESCRIPTION
    This script performs a deep clean of the system, uninstalling a large
    list of Microsoft Store (UWP) apps and applications provisioned via Winget.
    It also removes optional Windows components like WordPad, Media Player, and PowerShell ISE.
    Finally, it disables System Restore to free up space.
    The computer will be restarted upon completion.

.NOTES
    Author:      joao-vcthr
    Date:        09/21/2025
    Requirements: Must be run as Administrator.
    Warning:    The removals are permanent and may require manual reinstallation
                of a component if needed in the future.
#>

Write-Host "Uninstalling Apps..." -ForegroundColor Yellow

function Remove-MS-Apps() {
    $packages = @(
        "-allusers *Microsoft.549981C3F5F10*",
        "*windowsalarms*",
        "*windowscamera*",
        "*officehub*",
        "*getstarted*",
        "*zunemusic*",
        "*windowsmaps*",
        "*solitairecollection*",
        "*zunevideo*",
        "*bingnews*",
        "*onenote*",
        "*bingsports*",
        "*soundrecorder*",
        "*bingweather*",
        "*xboxapp*",
        "*WebExperience*"
    )
    Write-Host "Removing Microsoft Store apps" -ForegroundColor Yellow

    foreach($package in $packages) {
        Get-appxpackage $package | Remove-AppxPackage
    }

    Write-Host "MS Apps Removed"
}

function Remove-Winget-Apps () {

    $apps = @(
        "Microsoft.549981C3F5F10_8wekyb3d8bbwe",
        "Microsoft.WindowsCamera_8wekyb3d8bbwe",
        "Microsoft.XboxIdentityProvider_8wekyb3d8bbwe",
        "Microsoft.YourPhone_8wekyb3d8bbwe",
        "Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe",
        "Clipchamp.Clipchamp_yxz26nhyzhsrt",
        "Disney.37853FC22B2CE_6rarf9sa4v8jt",
        "Microsoft.OneDriveSync_8wekyb3d8bbwe",
        "Microsoft.PowerAutomateDesktop_8wekyb3d8bbwe",
        "MicrosoftCorporationII.QuickAssist_8wekyb3d8bbwe",
        "MicrosoftWindows.Client.WebExperience_cw5n1h2txyewy",
        "SpotifyAB.SpotifyMusic_zpdnekdrzrea0",
        "Microsoft.MSPaint_8wekyb3d8bbwe",
        "Microsoft.GamingApp_8wekyb3d8bbwe",
        "Microsoft.XboxGamingOverlay_8wekyb3d8bbwe",
        "MicrosoftCorporationII.MicrosoftFamily_8wekyb3d8bbwe",
        "MicrosoftCorporationII.QuickAssist_8wekyb3d8bbwe",
        "MicrosoftWindows.Client.WebExperience_cw5n1h2txyewy",
        "MSIX\MicrosoftWindows.CrossDevice_1.24091.30.0_x64__cw5n1h2txyewy",
        "MSIX\Microsoft.Copilot_0.4.2.0_neutral__8wekyb3d8bbwe",
        "--id=9MSSGKG348SP",  #Windows Web WebExperience
        "Microsoft.Teams",
        "Microsoft.DevHome",
        "Microsoft.Todos_8wekyb3d8bbwe"
    )

    winget source update
    Write-Host "Removing Winget Apps"

    foreach($app in $apps) {
        winget uninstall $app  -e
    }

    Write-Host "Winget Apps Removed"
}

function Remove-Windows-Capabilities() {

    $capabilities = @(
        "App.StepsRecorder~~~~0.0.1.0",
        "Hello.Face.20134~~~~0.0.1.0",
        "MathRecognizer~~~~0.0.1.0",
        "Media.WindowsMediaPlayer~~~~0.0.12.0",
        "Microsoft.Wallpapers.Extended~~~~0.0.1.0",
        "Microsoft.Windows.PowerShell.ISE~~~~0.0.1.0",
        "Microsoft.Windows.WordPad~~~~0.0.1.0",
        "OpenSSH.Client~~~~0.0.1.0"
    )

    Write-Host "Removing Optional Features(Windows Capabilities)"

    foreach($capability in $capabilities) {
        Remove-WindowsCapability -Online -Name $capability
    }

	Write-Host "Optional Features Removed"
}

function main() {
    Write-Host "Debloating Windows" -ForegroundColor Green

    Remove-MS-Apps
    Remove-Winget-Apps
    Remove-Windows-Capabilities

    Write-Host "Done! Restarting" -ForegroundColor Green

    #Start-Sleep -Seconds 5
    #Restart-Computer
}

main
