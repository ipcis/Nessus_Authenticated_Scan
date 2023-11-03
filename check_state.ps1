# Überprüfen des ersten Registry-Schlüssels und Werts
$registryPath1 = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters"
$registryValueName1 = "SmbServerNameHardeningLevel"

$registryValue1 = Get-ItemProperty -Path $registryPath1 -Name $registryValueName1

# Überprüfen des zweiten Registry-Schlüssels und Werts
$registryPath2 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$registryValueName2 = "LocalAccountTokenFilterPolicy"

$registryValue2 = Get-ItemProperty -Path $registryPath2 -Name $registryValueName2

if ($registryValue1.$registryValueName1 -eq 1) {
    Write-Host "Der Registry-Wert $registryValueName1 ist auf 1 gesetzt."
} else {
    Write-Host "Der Registry-Wert $registryValueName1 ist nicht auf 1 gesetzt oder nicht vorhanden."
}

if ($registryValue2.$registryValueName2 -eq 1) {
    Write-Host "Der Registry-Wert $registryValueName2 ist auf 1 gesetzt."
} else {
    Write-Host "Der Registry-Wert $registryValueName2 ist nicht auf 1 gesetzt oder nicht vorhanden."
}




#disable fw
#Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
