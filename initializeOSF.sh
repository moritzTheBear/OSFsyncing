pip install osfclient
cd "$(dirname "$0")"
osf init
# Create a script to upload files to OSF
cat << 'EOF' > updaten_mac.command
#!/bin/bash
echo "Enter your osf-username:"
read nutzername
echo "Enter your osf-password:"
read -s passwort
export OSF_PASSWORD=$passwort
echo "Thank you, this will now take a moment"
cd "$(dirname "$0")"
for item in $(osf -u $nutzername ls); do
    osf -u $nutzername remove "$item"
done
osf -u $nutzername upload -r hierUploaden/. Files
EOF
#create powershell script to upload files to OSF
cat << 'EOF' > updaten_win.ps1
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
EOF
# Create a script to download the OSF client
cat << 'EOF' > osfclientInstall_mac.command
#!/bin/bash
pip install osfclient
EOF

# create a powershell script to download the OSF client
cat << 'EOF' > osfclientInstall_win.ps1
pip install osfclient
EOF
mkdir hierUploaden
# Delete the script itself
rm -- "$0"
