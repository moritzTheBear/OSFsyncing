pip install osfclient
Set-Location -Path (Split-Path -Parent $MyInvocation.MyCommand.Definition)
osf init

# Create a script to upload files to OSF
@'
$nutzername = Read-Host "Enter your OSF username"
$passwort = Read-Host -AsSecureString "Enter your OSF password"
$env:OSF_PASSWORD = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($passwort))
Write-Output "Thank you, this will now take a moment"
cd "$PSScriptRoot"

# List and remove existing files
foreach ($item in (osf -u $nutzername ls)) {
    osf -u $nutzername remove $item
}

# Upload new files
osf -u $nutzername upload -r "hierUploaden/." "Files"
'@ > updaten_win.ps1
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
pip install osfclient
'@ > osfclientInstall_win.ps1
# Create a script to download the OSF client for macOS
@'
#!/bin/bash
pip install osfclient
'@ > osfclientInstall_mac.command


New-Item -ItemType Directory -Force -Path hierUploaden
Remove-Item -Force -LiteralPath $MyInvocation.MyCommand.Definition
