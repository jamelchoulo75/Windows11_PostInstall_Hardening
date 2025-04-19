# Windows11_PostInstall_Hardening
Windows11_PostInstall_Hardening
Post-Installation Hardening Script for Windows 11
Version: 1.0
Created by: Mous
Overview:
This script will perform various post-installation hardening tasks on Windows 11, including optimization, driver installation, cleanup, hardening, and security configurations. It also disables unnecessary services and applications, as well as applies hardening settings recommended by CIS and ANSSI benchmarks.
Instructions:
1. Copy the PowerShell script (Windows11_PostInstall_Hardening.ps1) and the batch file (Run_PostInstall.bat) to the same folder on your system.
2. Double-click on the batch file (Run_PostInstall.bat) to execute the PowerShell script automatically.
3. The script will perform the following actions:
   - Validate system state
   - Optimize performance
   - Install necessary drivers
   - Clean up temporary files
   - Perform hardening actions (disabling SMBv1, NetBIOS, etc.)
   - Enable security features like Exploit Guard, Network Protection, etc.
   - Uninstall bloatware like OneDrive and Cortana
   - Generate a report on the actions taken (saved as a .html file on the desktop)
4. A log file will be created on the desktop to track actions performed by the script.

Important:
- Make sure to run the batch file with administrator privileges.
- This script is intended for use on Windows 11 systems only.
- Do not interrupt the script during execution.

Disclaimer:
This script is shared for educational and personal use. Always ensure to back up your system before running any scripts.
