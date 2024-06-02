# Disable-Remote-Access

This PowerShell script disables all remote access functionalities in Windows, including Remote Desktop, Remote Assistance, and WinRM (Remote Shell). It is intended to enhance security by preventing unauthorized remote access to the system.


## Features

- Disables Remote Desktop
- Stops and disables Remote Desktop Services
- Disables Remote Assistance
- Stops and disables WinRM (Remote Shell)
- Displays a confirmation popup before executing

## Usage

1. Save the script `DisableRemoteAccess.ps1` and the batch file `RunDisableRemoteAccess.bat` in the same directory.
2. Double-click the `RunDisableRemoteAccess.bat` file to execute the script.
3. A confirmation popup will appear. Click "Yes" to proceed or "No" to cancel.

## Verification

The script includes verification steps that output the status of Remote Desktop, Remote Desktop Services, Remote Assistance, and WinRM to confirm they have been disabled.

