


Write-Host "Desinstalando Apps" -ForegroundColor Yellow

Get-appxpackage -allusers *Microsoft.549981C3F5F10* | Remove-AppxPackage
Get-AppxPackage *windowsalarms* | Remove-AppxPackage
Get-AppxPackage *windowscamera* | Remove-AppxPackage
Get-AppxPackage *officehub* | Remove-AppxPackage
Get-AppxPackage *getstarted* | Remove-AppxPackage
Get-AppxPackage *zunemusic* | Remove-AppxPackage
Get-AppxPackage *windowsmaps* | Remove-AppxPackage
Get-AppxPackage *solitairecollection* | Remove-AppxPackage
Get-AppxPackage *zunevideo* | Remove-AppxPackage
Get-AppxPackage *bingnews* | Remove-AppxPackage
Get-AppxPackage *onenote* | Remove-AppxPackage
Get-AppxPackage *bingsports* | Remove-AppxPackage
Get-AppxPackage *soundrecorder* | Remove-AppxPackage
Get-AppxPackage *bingweather* | Remove-AppxPackage
Get-AppxPackage *xboxapp* | Remove-AppxPackage
Get-AppxPackage *WebExperience* | Remove-AppxPackage

winget source update
winget uninstall Microsoft.549981C3F5F10_8wekyb3d8bbwe -e
winget uninstall Microsoft.WindowsCamera_8wekyb3d8bbwe -e
winget uninstall Microsoft.XboxIdentityProvider_8wekyb3d8bbwe -e
winget uninstall Microsoft.YourPhone_8wekyb3d8bbwe -e
winget uninstall Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe -e
winget uninstall Clipchamp.Clipchamp_yxz26nhyzhsrt -e
winget uninstall Disney.37853FC22B2CE_6rarf9sa4v8jt -e
winget uninstall Microsoft.OneDriveSync_8wekyb3d8bbwe -e
winget uninstall Microsoft.PowerAutomateDesktop_8wekyb3d8bbwe -e
winget uninstall MicrosoftCorporationII.QuickAssist_8wekyb3d8bbwe -e
winget uninstall MicrosoftWindows.Client.WebExperience_cw5n1h2txyewy -e
winget uninstall SpotifyAB.SpotifyMusic_zpdnekdrzrea0 -e
winget uninstall Microsoft.MSPaint_8wekyb3d8bbwe -e
winget uninstall Microsoft.GamingApp_8wekyb3d8bbwe -e
winget uninstall Microsoft.XboxGamingOverlay_8wekyb3d8bbwe -e
winget uninstall MicrosoftCorporationII.MicrosoftFamily_8wekyb3d8bbwe
winget uninstall MicrosoftCorporationII.QuickAssist_8wekyb3d8bbwe
winget uninstall MicrosoftWindows.Client.WebExperience_cw5n1h2txyewy
winget uninstall MSIX\MicrosoftWindows.CrossDevice_1.24091.30.0_x64__cw5n1h2txyewy
winget uninstall MSIX\Microsoft.Copilot_0.4.2.0_neutral__8wekyb3d8bbwe
winget uninstall --id=9MSSGKG348SP -e
winget uninstall Microsoft.Teams
winget uninstall Microsoft.DevHome
winget uninstall Microsoft.Todos_8wekyb3d8bbwe

Remove-WindowsCapability -Online -Name "App.StepsRecorder~~~~0.0.1.0"
Remove-WindowsCapability -Online -Name "Hello.Face.20134~~~~0.0.1.0"
Remove-WindowsCapability -Online -Name "MathRecognizer~~~~0.0.1.0"
Remove-WindowsCapability -Online -Name "Media.WindowsMediaPlayer~~~~0.0.12.0"
Remove-WindowsCapability -Online -Name "Microsoft.Wallpapers.Extended~~~~0.0.1.0"
Remove-WindowsCapability -Online -Name "Microsoft.Windows.PowerShell.ISE~~~~0.0.1.0"
Remove-WindowsCapability -Online -Name "Microsoft.Windows.WordPad~~~~0.0.1.0"
Remove-WindowsCapability -Online -Name "OpenSSH.Client~~~~0.0.1.0"

Write-Host "Bloatware removido." -ForegroundColor Green

Write-Host "Desativando e limpando Restauração do Sistema" -ForegroundColor Yellow
Disable-ComputerRestore -Drive "C:\"
vssadmin delete shadows /all
Write-Host "Restauração do sistema desativada e pontos de restauração excluidos" -ForegroundColor Green

Write-Host "Fim... reiniciando" -ForegroundColor Green

Start-Sleep -Seconds 10
Restart-Computer
