<#
=============================================================================================
Name:           Back up important documents to C drive
Description:    This script backs up Documents, Downloads, Desktop, Pictures, Chrome/Edge passwords and Chrome login details to the C drive. 
It runs as admin and accesses the currently logged in user's files.
Version:        1.0
Script by:      Fern Ritchie
============================================================================================
#> 


## How much free space, this will quit if there is less than 30 GB
$VarSpace = $(Get-WmiObject -Class win32_logicaldisk | Where-Object -Property Name -eq C:).FreeSpace
$inGB = $VarSpace/1gb


if ($inGB -le 30)
{

Write-Output "HELP I NEED MORE SPACE"
}

else {

Write-Output "Yay"

}

## Folder Variables
$backupFolder = "C:\Backup"
$chromeBackupFolder = "C:\Backup\Chrome"
$edgeBackupFolder = "C:\Backup\Edge"

## Get current user
$currentUser = (Get-WmiObject -Class Win32_ComputerSystem).UserName 
$actualCurrentUser = $currentUser -replace ".*\\" 


## Test to see if the folders exist, if not it will create them.


If (!(test-path -PathType container $backupFolder)) {
    New-Item -ItemType Directory -Path $backupFolder
}

If (!(test-path -PathType container $chromeBackupFolder)) {
    New-Item -ItemType Directory -Path $chromeBackupFolder
}


If (!(test-path -PathType container $edgeBackupFolder)) {
    New-Item -ItemType Directory -Path $edgeBackupFolder
}


## Copy Bookmarks from Chrome to Chrome back up folder

Copy-Item "C:\Users\$actualCurrentUser\AppData\Local\Google\Chrome\User Data\Default\Bookmarks" -Destination 'c:\Backup\Chrome' -Recurse

## Copy login data from Chrome to Chrome back up folder

Copy-Item "C:\Users\$actualCurrentUser\AppData\Local\Google\Chrome\User Data\Default\Login Data" -Destination 'c:\Backup\Chrome' -Recurse

## Copy Bookmarks from Edge to Edge back up folder

Copy-Item "C:\Users\$actualCurrentUser\AppData\Local\Microsoft\Edge\User Data\Default\Bookmarks" -Destination 'c:\Backup\Edge' -Recurse

## Copy Bookmarks from Documents to back up folder

Copy-Item "C:\Users\$actualCurrentUser\Documents" -Destination 'c:\Backup' -Recurse

## Copy Bookmarks from Pictures to back up folder

Copy-Item "C:\Users\$actualCurrentUser\Pictures" -Destination 'c:\Backup' -Recurse

## Copy Bookmarks from Downloads to back up folder

Copy-Item "C:\Users\$actualCurrentUser\Downloads" -Destination 'c:\Backup' -Recurse

## Copy Bookmarks from Desktop to back up folder

Copy-Item "C:\Users\$actualCurrentUser\Desktop" -Destination 'c:\Backup' -Recurse

