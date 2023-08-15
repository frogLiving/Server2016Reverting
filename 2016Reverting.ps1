# Purpose:	2016 Patches Reverting fix
# Date:		07/28/2023

param ($reboot = 0)

# Values
$keyPath = "HKLM:\System\CurrentControlSet\Services\EventLog\Application"
$key = Get-ItemProperty -Path HKLM:\System\CurrentControlSet\Services\EventLog\Application | Select MaxSize

# Replacing keys
Write-Output "Fixing registry keys!"
if ($key -ne $null) {
	Remove-ItemProperty -Path $keyPath -Name MaxSize -ErrorAction SilentlyContinue | Out-Null
	New-ItemProperty -Path $keyPath -Name MaxSize -PropertyType Dword -Value 1400000  | Out-Null
}

# Kick off SFC /scannow
Write-Output "Running SFC!"
Start-Process -FilePath "C:\Windows\system32\sfc.exe" -ArgumentList "/scannow" -Wait

# Kick off Dism
Write-Output "Running DISM!"
Start-Process -FilePath "C:\Windows\system32\dism.exe" -ArgumentList "/online /cleanup-image /restorehealth" -Wait

if ($reboot) { shutdown -r -t 0 }