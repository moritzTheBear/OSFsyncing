pip install osfclient
Set-Location -Path (Split-Path -Parent $MyInvocation.MyCommand.Definition)
osf init

# Create a script to upload files to OSF
@'
@echo off
echo Enter your osf-username:
set /p nutzername=
echo Enter your osf-password:
set /p passwort=
set OSF_PASSWORD=%passwort%
echo Thank you, this will now take a moment
cd "%~dp0"
for /f "tokens=*" %%i in ('osf -u %nutzername% ls') do (
    osf -u %nutzername% remove "%%i"
)
osf -u %nutzername% upload -r hierUploaden/. Files
'@ > updaten_win.bat
# Create a script to upload files to OSF for macOS
@'
#!/bin/bash
read -p "Enter your osf-username: " nutzername
read -sp "Enter your osf-password: " passwort
export OSF_PASSWORD=$passwort
echo "\nThank you, this will now take a moment"
cd "$(dirname "$0")"
osf -u $nutzername ls | while read -r line; do
    osf -u $nutzername remove "$line"
done
osf -u $nutzername upload -r hierUploaden/. Files
'@ > updaten_mac.command

chmod +x updaten_mac.command

# Create a script to download the OSF client
@'
@echo off
pip install osfclient
'@ > osfclientInstall_win.bat
# Create a script to download the OSF client for macOS
@'
#!/bin/bash
pip install osfclient
'@ > osfclientInstall_mac.command

chmod +x osfclientInstall_mac.command

New-Item -ItemType Directory -Force -Path hierUploaden
Remove-Item -Force -LiteralPath $MyInvocation.MyCommand.Definition
