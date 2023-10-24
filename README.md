# Nessus_Authenticated_Scan

```
Troubleshooting Authenticated Nessus Audits:
https://www.youtube.com/watch?v=CFwJQTr8t_k


Accounts
add a Admin acccount


Inbound FW
137, 139, 445


Services
Remote Registry
Winmgmt


Registry
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters\SmbServerNameHardeningLevel = 1
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\LocalAccountTokenFilterPolicy = 1



AV
Exception may needed


Windows Features
SMB 1.0 - activate (only if it is not working)
```




powershell 
Set-Executionpolicy bypass
./
