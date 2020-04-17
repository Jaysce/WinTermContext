$x = $env:USERPROFILE
$x -match "C:\\Users\\(?<content>.*)"
$user = $matches['content']
$installdir = "$env:localappdata\\WinTerminalContextMenu"

# Store the registry key location in $location
$location = 'Registry::HKEY_CLASSES_ROOT\Directory\Background\shell'

# Adds that location at the top of the stack
Push-Location
Set-Location $location

# Test if the 'WindowsTerminal' key or 'WindowsTerminalAdmin' key already exists
if (Test-Path "$location\WindowsTerminal") {
    Write-Verbose 'Uninstalling' -Verbose
    Remove-Item -Path "$location\WindowsTerminal" -Recurse
    Remove-Item -Path "$location\WindowsTerminalAdmin" -Recurse
    Remove-Item -Path $installDir -Recurse
}
else {

    # Copy terminal icon to AppData

    New-Item  $installdir -ItemType Directory
    Copy-Item "$PSScriptRoot\\Icon\\terminal.ico" -Destination $installdir

    # If not create new key called WindowsTerminal
    New-Item -Path "$location" -Name 'WindowsTerminal' -Value "Open Terminal here"
    # Add the icon path property
    New-ItemProperty -Path "$location\WindowsTerminal" -Name "Icon" -Value "$installDir\\terminal.ico" -PropertyType 'String'

    # Create new key called command in WindowsTerminal
    New-Item -Path "$location\WindowsTerminal" -Name 'command' -Value "$env:localappdata\\Microsoft\\WindowsApps\\wt.exe -d ."

    # Create new key called WindowsTerminalAdmin
    New-Item -Path "$location" -Name 'WindowsTerminalAdmin' -Value "Open Terminal as Admin here"
    # Add the icon path property
    
    New-ItemProperty -Path "$location\WindowsTerminalAdmin" -Name "Icon" -Value "$installDir\\terminal.ico" -PropertyType 'String'

    # Create new key called command in WindowsTerminalAdmin
    New-Item -Path "$location\WindowsTerminalAdmin" -Name 'command' -Value "Powershell -WindowStyle Hidden -Command `"Start-Process wt.exe -ArgumentList '-d .' -Verb runAs`"" -ItemType 'String'
    
    Pop-Location

}

Pause