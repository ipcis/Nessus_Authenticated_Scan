$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$registryValueName = "LocalAccountTokenFilterPolicy"

$registryValue = Get-ItemProperty -Path $registryPath -Name $registryValueName

if ($registryValue.$registryValueName -eq 1) {
    Write-Host "Der Registry-Wert $registryValueName ist auf 1 gesetzt."
} else {
    Write-Host "Der Registry-Wert $registryValueName ist nicht auf 1 gesetzt oder nicht vorhanden."
}



#disable fw
#Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
