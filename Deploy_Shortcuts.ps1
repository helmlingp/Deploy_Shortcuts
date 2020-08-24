<#	
    .Synopsis
      This powershell script creates shortcuts.
    .NOTES
	  Created:   	August, 2020
	  Created by:	Phil Helmling, @philhelmling
	  Organization: VMware, Inc.
	  Filename:     Deploy_Shortcuts.ps1
	.DESCRIPTION
	  This powershell script creates shortcuts. Edit the array to add the shortcut metadata
      Array requires TargetFile,ShortcutFile,Arguments,IconLocation
      For Example:
        TargetFile='AAA';ShortcutFile='BBB';Arguments='CCC';IconLocation='DDD, 0'
    .EXAMPLE
      powershell.exe -ep bypass -file .\Deploy_Shortcuts.ps1
#>
$current_path = $PSScriptRoot;
if($PSScriptRoot -eq ""){
    #PSScriptRoot only popuates if the script is being run.  Default to default location if empty
    $current_path = "C:\Temp";
}

#Array of Shortcuts
$shortcutsarray = @(

       [pscustomobject]@{TargetFile='AAA';ShortcutFile='BBB';Arguments='CCC';IconLocation='DDD, 0'}

   )
foreach ($item in $shortcutsarray) {
    #Make sure the path to store the shortcut exists
    $shortcutpath = $item.ShortcutFile.Substring(0,$item.ShortcutFile.LastIndexOf('\'))
    write-host $shortcutpath
    If(!(test-path $shortcutpath)){
        New-Item -ItemType Directory -Force -Path $shortcutpath
    }
    # Create the Shortcut
    $WScriptShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WScriptShell.CreateShortcut($item.ShortcutFile)
    $Shortcut.TargetPath = $item.TargetFile
    $ShortCut.IconLocation = $item.IconLocation;
    $ShortCut.Arguments = $item.Arguments
    $Shortcut.Save()
}




