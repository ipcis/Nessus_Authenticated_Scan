# Überprüfen, ob die PowerShell-Sitzung mit Administratorrechten ausgeführt wird
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Führen Sie dieses Skript als Administrator aus."
    Exit
}




# Überprüfen, ob die Windows-Firewall aktiviert ist
$firewallStatus = Get-NetFirewallProfile | Where-Object { $_.Name -eq "Public" }

if ($firewallStatus.Enabled) {
    Write-Host "Die Windows-Firewall ist aktiviert."

    # Ausnahme für Datei- und Druckerfreigabe (SMB)
    New-NetFirewallRule -DisplayName "SMB" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 137,139,445

    # Ausnahme für WMI-RPC
    New-NetFirewallRule -DisplayName "WMI-RPC" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 135
    New-NetFirewallRule -DisplayName "WMI-RPC" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 445
} else {
    Write-Host "Die Windows-Firewall ist nicht aktiviert."
}




# Starten und konfigurieren des WMI-Dienstes
Set-Service -Name "winmgmt" -StartupType Manual
Start-Service -Name "winmgmt"


# Starten und konfigurieren des RemoteRegistry-Dienstes
Set-Service -Name "RemoteRegistry" -StartupType Manual
Start-Service -Name "RemoteRegistry"


# Aktiviere die Administrator-Freigaben (C$ und D$)
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "LocalAccountTokenFilterPolicy" -Value 1 -PropertyType DWORD -Force

# SMB Key
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "SmbServerNameHardeningLevel" -Value 1 -Force



# Aktiviere SMB1
Enable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol

# Aktiviere SMB2
Set-SmbServerConfiguration -EnableSMB2Protocol $true

# Aktiviere WMI-Remoting
Enable-PSRemoting -Force
