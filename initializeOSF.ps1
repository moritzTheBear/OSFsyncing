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
'@ > updaten.cmd

# Create a script to download the OSF client
@'
@echo off
pip install osfclient
'@ > osfclientInstall.cmd

New-Item -ItemType Directory -Force -Path hierUploaden
Remove-Item -Force -LiteralPath $MyInvocation.MyCommand.Definition
