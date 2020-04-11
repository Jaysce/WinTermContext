# WinTermContext
**NOTE: Open Terminal as Admin seems to only work on Windows 10 build 2004 or later**

A PowerShell script that creates an option in the file explorer context menu to launch Windows Terminal from that directory

![Context Menu](https://i.imgur.com/rAN6VUel.png)

## Installation
1. Clone this repo to the root (C:\\>)
2. Set Execution Policy for CurrentUser to RemoteSigned by running
   PowerShell as Admin and running `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser` 

3. Run the install.ps1 script as Admin from PowerShell
`C:\WinTermContext> .\install.ps1` 
