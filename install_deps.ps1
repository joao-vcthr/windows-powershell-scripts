<#
.SYNOPSIS
    Installs a set of essential dependencies and runtimes for games and applications.

.DESCRIPTION
    Using Winget, this script automates the installation of various versions
    of the following dependency packages:
    - .NET Runtime and .NET Desktop Runtime
    - Microsoft Visual C++ Redistributable (VCRedist)
    - Microsoft DirectX

.NOTES
    Author:      joao-vcthr
    Date:        09/21/2025
    Requirements: Must be run as Administrator. An internet connection is required.
#>

$deps = @(
    "Microsoft.DotNet.Runtime.6",
    "Microsoft.DotNet.DesktopRuntime.8",
    "Microsoft.DotNet.DesktopRuntime.9",
    "Microsoft.VCRedist.2005.x64",
    "Microsoft.VCRedist.2005.x86",
    "Microsoft.VCRedist.2008.x64",
    "Microsoft.VCRedist.2008.x86",
    "Microsoft.VCRedist.2010.x64",
    "Microsoft.VCRedist.2010.x86",
    "Microsoft.VCRedist.2012.x64",
    "Microsoft.VCRedist.2012.x86",
    "Microsoft.VCRedist.2013.x64",
    "Microsoft.VCRedist.2013.x86",
    "Microsoft.VCRedist.2015+.x64",
    "Microsoft.VCRedist.2015+.x86",
    "Microsoft.DirectX"
)

Write-Host "Installing dependencies..." -ForegroundColor Yellow

winget source update

foreach($dep in $deps) {
    winget install --id $dep -e --accept-package-agreements --accept-source-agreements --source winget
}

Write-Host "Dependencies installed! Restart the computer." -ForegroundColor Green
