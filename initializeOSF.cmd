pip install osfclient
cd "$(dirname "$0")"
osf init
# Create a script to upload files to OSF
cat << 'EOF' > updaten.cmd
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
# Create a script to download the OSF client
cat << 'EOF' > osfclientInstall.cmd
#!/bin/bash
pip install osfclient
EOF

chmod +x updaten.command
mkdir hierUploaden
# Delete the script itself
rm -- "$0"
