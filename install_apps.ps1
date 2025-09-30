<#
.SYNOPSIS
    Installs a list of common user applications via Winget.

.DESCRIPTION
    This script automates the download and installation of a standard set of
    communication, gaming, and utility applications.
    The list includes Bitwarden, Discord, Steam, Epic Games, Riot Games
    GOG Galaxy, EA Desktop, RetroArch, OBS Studio, Bulk Crap Uninstaller, HWiNFO, CPU-Z, GPU-Z and Fastfetch

.NOTES
    Author:      joao-vcthr
    Date:        09/21/2025
    Requirements: Must be run as Administrator. An internet connection is required.
#>

$winget_apps = @(
    "Discord.Discord",
    "Valve.Steam",
    "EpicGames.EpicGamesLauncher",
    "RiotGames.LeagueOfLegends.BR",
    "GOG.Galaxy",
    "ElectronicArts.EADesktop",
    "Libretro.RetroArch",
    "OBSProject.OBSStudio",
    "BleachBit.BleachBit",
    "Klocman.BulkCrapUninstaller",
    "REALiX.HWiNFO",
    "CPUID.CPU-Z",
    "TechPowerUp.GPU-Z",
    "Fastfetch-cli.Fastfetch"
)

Write-Host "Downloading and installing apps..." -ForegroundColor Yellow

winget source update

foreach( $app in $winget_apps) {
    winget install --id $app -e --accept-package-agreements --accept-source-agreements --source winget
}

Write-Host "Apps have been installed!" -ForegroundColor Green
