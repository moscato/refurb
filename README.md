# refurb
Refurb manager with system specifics and frequently checked locations.


This script was written to generate inventory tags for a used computer store.

Information generated will be stored and appended to .txt files in the directory from which the script was ran, in a folder named belly-tag.
  Script will create this directory if it doesn't already exist.

There are two versions, for laptop and desktop.

The laptop script will give screen size and open camera for testing if available.

The desktop version foregoes the camera and reports motherboard instead of screen size.


It should be noted that while this script is generally dependable and has been implemented for commercial use in the past, it does have some hiccups.

Script does not play well with multiple drives and will often report drive type incorrectly.
  This is due to drive infor being pulled from the [0] index of Get-PhysicalDisk cmdlet.
  
Script throws an error on some info on Windows 11 machines where win32 object is no longer available.

