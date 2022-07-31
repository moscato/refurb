# Refurb
Refurb manager with system specifics and frequently checked locations.


This script was written to generate inventory tags for a used computer store.

Information generated will be stored and appended to .txt files in the directory from which the script was ran, in a folder named info.
  Script will create this directory if it doesn't already exist.

There are two versions, for laptop and desktop.

The laptop script will give screen size and open camera for testing if available.

The desktop version foregoes the camera and reports motherboard instead of screen size.


<h2><i>This script is MIT licensed and should be changed, twisted, and contorted however anyone shall see fit!</i></h2>


It should be noted that while this script is generally dependable and has been implemented for commercial use in the past, it does have some hiccups.
Problems are as follows.

- <strike>Cannot retrieve screen size for laptops</strike>

- <strike> Get-PhysicalDisk portion also returns external drive.</strike> <br>
   <strike>Trying to isolate by number field is ineffective. Does not appear to be integer or string data-type</strike>

- Not sure how to return available display ports (hdmi, vga etc...)

- Not sure how to return battery health.<br> 
  Perhaps Win32_BIOS? Win32_Battery exists but does not provide useful results

- Script does not play well with multiple drives and will often report drive type incorrectly. <br>
    This is due to drive info being pulled from the [0] index of Get-PhysicalDisk cmdlet.

- Does not report WiFi info, instead pulling up Network Status in settings to find this information manually if necessary.
   
- Windows 11 is presenting an interesting challenge with calling the [0] index on drive info. <br>
  Prints an error about indexing to a null array.
  
  <hr><hr>
  
-----------------------------------------------------------------------------------------------------------------------
CHANGE LOG
-----------------------------------------------------------------------------------------------------------------------
    
  <u>Change-Log 7/31/22</u>
  
  Optimized for gov applications.
  
  Removed that pesky string Write-Host for internet options in favor of opening Network Status in Tech info.
  
  Replaced the term belly-tag with info because professional.
  
  Removed Activation check entirely.
  
  <hr><hr>
  
  <u>Change-Log 8/25/21</u>
  
  Fun New Headers!
  
  Used -eq instead of = to resolve ram type and activation problems
  
  Resolved external drive issue by isolating first position of ForEach loop through drive types
     (Thanks Lwed for suggesting LogicalDisk over PhysicalDrive)
  
  Implemented WmiMonitorBasicDisplayParams to retrieve screen size (thanks again to Lwed)
  
  Added command to open file explorer to expose script in recent files, and file explorer options to clear it.
  
    
  <hr><hr>
  
  <u>Change-Log 9/4/21</u>
  
  Implemented Start-Transcript with $mod variable to output .txt files of script info
   <br>(use -Path flag to dictate this output to another location)
   
  Get-WmiObject win32_videocontroller call now uses $_.Name vs $_.Description for more consistent results
  
  Removed activation check and replaced with ms-settings:activation
 
   <hr><hr>
  
  <u>Change-Log 9/11/21</u>
  
  What an exciting Week!
  
  overcame unnecessary spaces after variable calls using $($_.<i>varName</i>) 
    <br> this saves a lot of work and has a lot of potential for the future of this project.
    
  Get-Ciminstance Win32_OperatingSystem | % caption added to determine windows 10 home / pro
   
  added get-date to the end of tech infovsection for easier identification in transcript.
   
   <hr><hr>
  
  <u>Change-Log 9/19/21</u>
 
  Get-WmiObject Win32_physicalMemoryArray | % {$_.Memorydevices} added to return available slots
  
  [math]::Round() used to round out screen size on laptop edition.
  
  Minor gramatical fixes. Capitalizing and indenting for cleaner code.
  
     <hr><hr>
  
  <u>Change-Log 9/26/21</u>
 
  .Replace() used to clean up cpu and video controller output
  
  Minor gramatical fixes. Capitalizing and indenting for cleaner code.
  
   <hr><hr>
  
  <u>Change-Log 10/10/21</u>
   
  Replaced all Select-Object with ? and Foreach-Object with % for consistency.

  Added if statements for error catch to drive type and video controller. <br>
   (Video controller error catch only works with intel products.)
  


