# Vars
$PaydayPath = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 218620' -Name InstallLocation).InstallLocation
$PaydayExe = Get-Process 'payday2_win32_release' -ErrorAction SilentlyContinue
$DevFolder = (Get-Item (Split-Path $PSCommandPath -Parent)).Parent.FullName

# Run the script only if PAYDAY 2 is installed
if([System.IO.Directory]::Exists(${PaydayPath})) {
	# Close PAYDAY 2 if it's running
	if (${PaydayExe}) {
		${PaydayExe}.CloseMainWindow()
		Start-Sleep 2
		if (!${PaydayExe}.HasExited) {
			${PaydayExe} | Stop-Process -Force
		}
	}

	# Delete Real Weapon Names folder contents
	Remove-Item ${PaydayPath}'\mods\Real Weapon Names\*' -Recurse

	# Copy the mod files inside the game's "mods" folder
	New-Item -ItemType Directory -Path ${PaydayPath}'\mods\Real Weapon Names\lua' | Out-Null
	Copy-Item -Path ${DevFolder}'\lua\*.lua' -Destination ${PaydayPath}'\mods\Real Weapon Names\lua\' -Recurse | Out-Null
	New-Item -ItemType Directory -Path ${PaydayPath}'\mods\Real Weapon Names\lua\loc' | Out-Null
	Copy-Item -Path ${DevFolder}'\lua\loc\*.json' -Destination ${PaydayPath}'\mods\Real Weapon Names\lua\loc\' -Recurse | Out-Null
	Copy-Item -Path ${DevFolder}'\mod.txt' -Destination ${PaydayPath}'\mods\Real Weapon Names' | Out-Null
	Copy-Item -Path ${DevFolder}'\RWN.png' -Destination ${PaydayPath}'\mods\Real Weapon Names' | Out-Null

	# Launch PAYDAY 2
	# Launching the game from the shell will make SuperBLT create logs inside ${DevFolder}
	# Start-Process ${PaydayPath}'\payday2_win32_release.exe'
	Start-Process 'steam://run/218620'

	# Quit the script
	exit
}
