

$winget_apps = @(
    "Bitwarden.Bitwarden",
    "Discord.Discord",
    "Valve.Steam",
    "EpicGames.EpicGamesLauncher",
    "RiotGames.LeagueOfLegends.BR",
    "GOG.Galaxy",
    "ElectronicArts.EADesktop",
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
