

  $mod = Get-WmiObject Win32_ComputerSystem | % {$_.Model}
  $ser = Get-WmiObject Win32_BIOS | ? $_.SerialNumber
  Start-Transcript -append -Path ".\info\$ser -info.txt"
 

Write-Host ' '
Write-Host "Info -- *DeskTop Edition!*" -foregroundcolor green
Write-Host "---------------------------------" -foregroundcolor green

$ddr = Get-WmiObject Win32_PhysicalMemory | ? SMBIOSMemoryType | % {$_.SMBIOSMemoryType}


  if ($ddr -eq 21) {
	$ddr = 'DDR2'
  } elseif ($ddr -eq 26) {
	$ddr = 'DDR4'
  }  elseif ($ddr -eq 22) {
	$ddr = 'DDR2 FB-DIMM'
  } elseif ($ddr -eq 24) {
	$ddr = 'DDR3'
  } elseif ($ddr -eq 20) {
	$ddr = 'DDR'
  }

Get-WmiObject Win32_ComputerSystem | ? {Write-Host $_.Model}
Get-WmiObject win32_baseboard | ? {Write-Host $_.Manufacturer $_.Product}
  

  $cpuName = Get-WmiObject Win32_processor | % {$_.name}
  $cores = Get-WmiObject Win32_processor | % {$_.NumberOfCores}
  $threads = Get-WmiObject Win32_processor | % {$_.NumberOfLogicalProcessors}
  
Write-Host $cpuName.Replace("(R)", "").Replace("(TM)", "").Replace(" CPU", "").Replace("@ ", "@") "($($cores) Cores $($threads) Threads)"

				#Get-wmiObject win32_processor | ? {Write-Host $_.name "|" $_.NumberOfCores "Cores" $_.NumberOfLogicalProcessors"Threads"}

  $memTotal = Get-WmiObject Win32_physicalMemory | % {($_.capacity/1gb)}
  $memSlots = Get-WmiObject Win32_physicalMemoryArray | % {$_.Memorydevices}
  $memFirst = $memTotal[0]

Write-Host "$($memTotal) GB $($ddr) ($($memFirst) GB x $($memSlots) Slots)"


$vc = Get-WmiObject win32_videocontroller | %  {$_.Name}

Write-Host $vc.Replace("(R)", "").Replace("(TM)", "")


  $stor = Get-WmiObject Win32_LogicalDisk | ? {$_.DeviceId -eq "C:"} | % {"{0:N0}" -f ($_.Size/1gb)}
  $dt = Get-PhysicalDisk | % { $_.MediaType }
  $dtFin = $dt[0]

	Start-Sleep -Milliseconds 2000
  
  
  if ($dtFin -eq 'H') {
	  $dtFin = 'HDD'  
	  Write-Host $stor "GB" $dtFin
  } elseif ($dtFin -eq 'S') {
	  $dtFin = 'SSD'  
	  Write-Host $stor "GB" $dtFin
  } elseif ($dtFin -eq 'u') {
	  $dtFin = ' ~~~ UNSPECIFIED, PLEASE CHECK ON SYSTEM ~~~ '  
	  Write-Host $stor "GB" $dtFin -foregroundcolor red
  } elseif ($dtFin -eq 'unspecified') {
	  $dtFin = ' ~~~ UNSPECIFIED, PLEASE CHECK ON SYSTEM ~~~ '  
	  Write-Host $stor "GB" $dtFin -foregroundcolor red
  } else {
	  Write-Host $stor "GB" $dtFin
  }
  

Write-Host "Gigabit Ethernet"

  $Vers = Get-Ciminstance Win32_OperatingSystem | % caption

  if ($Vers -eq "Microsoft Windows 10 Pro") {
	Write-Host "Windows 10 Pro"
  } elseif ($Vers -eq "Microsoft Windows 10 Home") {
	Write-Host "Windows 10 Home"
  }  elseif ($Vers -eq "Microsoft Windows 11 Pro") {
	Write-Host "Windows 11 Pro"
  }  elseif ($Vers -eq "Microsoft Windows 11 Home") {
	Write-Host "Windows 11 Home"
  }  else {
	Write-Host "Windows ~~"
	Start-Process winver
  }
  


Write-Host "---------------------------------" -foregroundcolor green
Write-Host "Continue for tech info..." -foregroundcolor green


pause

$exec = Get-ExecutionPolicy

Write-Host 'Tech Info ~~' -foregroundcolor yellow
write-Host "---------------------------------" -foregroundcolor yellow
Get-WmiObject Win32_BIOS | ? {Write-Host "Serial Number: "  $_.SerialNumber -foregroundcolor yellow}
Write-Host 'ExecutionPolicy is set to: '$exec  -foregroundcolor yellow
Start-Process devmgmt.msc
Write-Host 'Device manager is open' -foregroundcolor yellow
Write-Host "File Explorer Options is open to clear recent history" -foregroundcolor yellow
Write-Host "^^explorer is open to prove this +-- Testing purposes --+" -foregroundcolor yellow
Get-ControlPanelItem -Name "File Explorer Options" | Show-ControlPanelItem
Start-Process explorer.exe
Write-Host "Network Status opened for internet information." -foregroundcolor yellow
Start-Process "ms-settings:network-status"

$date = Get-Date
Write-Host "Date is: $date" -foregroundcolor yellow
  
Stop-Transcript
Write-Host "~~ Press Enter to exit PowerShell ~~" -foregroundcolor green

pause
