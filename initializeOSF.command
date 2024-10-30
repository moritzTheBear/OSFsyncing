pip install osfclient
cd "$(dirname "$0")"
osf init
cat << 'EOF' > updaten.command
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

chmod +x updaten.command
mkdir hierUploaden
