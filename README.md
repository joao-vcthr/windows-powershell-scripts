# Windows 11 Post-Install Scripts for Gaming

This repository contains a collection of PowerShell scripts to automate the setup and optimisation of a **fresh Windows 11 installation** for gaming.

## ⚠️ Disclaimer

These scripts make significant changes to your system, including removing apps, disabling services, and modifying system settings. They are provided as-is, and you should review them before running. Use them at your own risk.

## Dependencies & Requirements

* **Clean Windows 11 installation.**
* **Run as Administrator:** All scripts must be run with administrative privileges.
* **Internet Connection:** Required for `winget` to download applications.
* **No external modules needed:** The scripts rely only on built-in PowerShell cmdlets and official Windows command-line tools (like `winget`, `DISM`, etc.).

## Recommended Order

For the best results, it is recommended to run the scripts in the following sequence:

1.  `first_setup.ps1` - Applies initial system configurations.
2.  `debloat-windows.ps1` - Removes pre-installed Windows apps. (Run this after fully updating the system and installing drivers.)
3.  `install_deps.ps1` - Installs essential runtimes (.NET, VC++, etc.).
4.  `install_apps.ps1` - Installs user applications.
5.  `final_setup.ps1` - Applies final performance tweaks.
6.  `cleanup.ps1` - Performs system health checks and maintenance.

