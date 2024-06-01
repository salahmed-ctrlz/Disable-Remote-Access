@echo off
echo Running DisableRemoteAccess PowerShell script...
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0DisableRemoteAccess.ps1"
pause
