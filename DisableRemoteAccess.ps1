Add-Type -AssemblyName System.Windows.Forms

# Show confirmation dialog
$confirmationResult = [System.Windows.Forms.MessageBox]::Show("This script will disable Remote Desktop, Remote Assistance, and WinRM. Do you want to proceed?", "Confirmation", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Warning)

if ($confirmationResult -eq [System.Windows.Forms.DialogResult]::Yes) {
    # Disable Remote Desktop
    Write-Output "Disabling Remote Desktop..."
    try {
        Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\' -Name 'fDenyTSConnections' -Value 1 -ErrorAction Stop
        Write-Output "Remote Desktop disabled successfully."
    } catch {
        Write-Output "Failed to disable Remote Desktop: $_"
    }

    # Stop and Disable Remote Desktop Services
    Write-Output "Stopping and disabling Remote Desktop Services..."
    try {
        Stop-Service -Name TermService -Force -ErrorAction Stop
        Set-Service -Name TermService -StartupType Disabled -ErrorAction Stop
        Write-Output "Remote Desktop Services stopped and disabled successfully."
    } catch {
        Write-Output "Failed to stop and disable Remote Desktop Services: $_"
    }

    # Disable Remote Assistance
    Write-Output "Disabling Remote Assistance..."
    try {
        Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance' -Name 'fAllowToGetHelp' -Value 0 -ErrorAction Stop
        Write-Output "Remote Assistance disabled successfully."
    } catch {
        Write-Output "Failed to disable Remote Assistance: $_"
    }

    # Disable WinRM (Remote Shell)
    Write-Output "Disabling WinRM (Remote Shell)..."
    try {
        Stop-Service -Name WinRM -ErrorAction Stop
        Set-Service -Name WinRM -StartupType Disabled -ErrorAction Stop
        Write-Output "WinRM (Remote Shell) disabled successfully."
    } catch {
        Write-Output "Failed to disable WinRM (Remote Shell): $_"
    }

    # Confirm changes
    Write-Output "Verification:"
    try {
        $rdpStatus = Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\' -Name 'fDenyTSConnections'
        $rdpServiceStatus = Get-Service -Name TermService
        $remoteAssistanceStatus = Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance' -Name 'fAllowToGetHelp'
        $winrmServiceStatus = Get-Service -Name WinRM

        Write-Output "Remote Desktop status (1 = Disabled, 0 = Enabled): $($rdpStatus.fDenyTSConnections)"
        Write-Output "Remote Desktop Service status: $($rdpServiceStatus.Status)"
        Write-Output "Remote Assistance status (0 = Disabled, 1 = Enabled): $($remoteAssistanceStatus.fAllowToGetHelp)"
        Write-Output "WinRM Service status: $($winrmServiceStatus.Status)"
    } catch {
        Write-Output "Failed to retrieve status: $_"
    }
} else {
    Write-Output "Operation cancelled by the user."
}
