

  $mod = Get-WmiObject Win32_ComputerSystem | % {$_.Model}
  Start-Transcript -append -Path ".\info\$mod -info.txt"

#Start-Transcript -append -Path "D:\$mod -info.txt"

#out-file E:\info.txt -encoding UTF8
Write-Host ' '
Write-Host "Info -- *LapTop Edition!*" -foregroundcolor green
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
  $ss = Get-WmiObject -Namespace root\wmi -Class WmiMonitorBasicDisplayParams | select @{ N="Computer"; E={$_.__SERVER} }, @{N="Size"; E={[System.Math]::Round(([System.Math]::Sqrt([System.Math]::Pow($_.MaxHorizontalImageSize, 2) + [System.Math]::Pow($_.MaxVerticalImageSize, 2))/2.54),2)} } | % {$_.Size}
  $ssFin = [math]::Round($ss[0])
  $horz = Get-WmiObject Win32_VideoController | % {$_.CurrentHorizontalResolution}
  $verz = Get-WmiObject Win32_VideoController | % {$_.CurrentVerticalResolution}
  
  Write-Host "$($ssFin)`" HD LCD Screen ($($horz) x $($verz))"
  
				#Get-WmiObject Win32_VideoController | ? {Write-Host ($ssFin)'" HD LCD Screen ('$_.CurrentHorizontalResolution 'x' $_.CurrentVerticalResolution')'}

  $cpuName = Get-WmiObject Win32_processor | % {$_.name}
  $cores = Get-WmiObject Win32_processor | % {$_.NumberOfCores}
  $threads = Get-WmiObject Win32_processor | % {$_.NumberOfLogicalProcessors}
  
Write-Host $cpuName.Replace("(R)", "").Replace("(TM)", "").Replace(" CPU", "").Replace("@ ", "@") "($($cores) Cores $($threads) Threads)"

				#Get-wmiObject win32_processor | ? {Write-Host $_.name "|" $_.NumberOfCores "Cores" $_.NumberOfLogicalProcessors"Threads"}

  $memTotal = Get-WmiObject Win32_physicalMemory | % {($_.capacity/1gb)}
  $memSlots = Get-WmiObject Win32_physicalMemoryArray | % {$_.Memorydevices}
  $memFirst = $memTotal[0]

Write-Host "$($memTotal) GB $($ddr) ($($memFirst) GB x $($memSlots) Slots)"

				#Write-Host Get-WmiObject Win32_PhysicalMemory | ? {Write-Host ($_.capacity/1gb) "GB" $ddr}
				
  $vc = Get-WmiObject win32_videocontroller | %  {$_.Name}

Write-Host $vc.Replace("(R)", "").Replace("(TM)", "")

  $stor = Get-WmiObject Win32_LogicalDisk | ? {$_.DeviceId -eq "C:"} | % {"{0:N0}" -f ($_.Size/1gb)}
				#$stor = Get-WmiObject Win32_LogicalDisk | ? {($_.Size/1gb) -gt 100} | % {"{0:N0}" -f $_.Size/1gb)}
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
  
		#Write-Host $stor "GB" $dtFin


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
Write-Host "---------------------------------" -foregroundcolor yellow
Get-WmiObject Win32_BIOS | ? {Write-Host "Serial Number: "  $_.SerialNumber -foregroundcolor yellow}
Write-Host 'ExecutionPolicy is set to: '$exec  -foregroundcolor yellow
Start-Process devmgmt.msc
Write-Host 'Device manager is open' -foregroundcolor yellow
Write-Host "File Explorer Options is open to clear recent history" -foregroundcolor yellow
Write-Host "^^explorer is open to prove this +-- Testing purposes --+" -foregroundcolor yellow
            # Start-Process ms-settings:activation
            # Write-Host "Windows activation is open" -foregroundcolor yellow
Start-Process explorer.exe
Write-Host "Network Status opened for internet information." -foregroundcolor yellow
Start-Process "ms-settings:network-status"
Get-ControlPanelItem -Name "File Explorer Options" | Show-ControlPanelItem

Start-Process microsoft.windows.camera:
Write-Host 'Camera is open for testing.' -foregroundcolor yellow


  $date = Get-Date
Write-Host "Date is: $date"  -foregroundcolor yellow

Stop-Transcript
Write-Host "~~ Press Enter to exit PowerShell ~~" -foregroundcolor green

pause


