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


# Create a script to download the OSF client
@'
pip install osfclient
'@ > osfclientInstall_win.ps1


if (-Not (Test-Path -Path "hierUploaden")) {
    New-Item -ItemType Directory -Force -Path hierUploaden
}
Remove-Item -Force -LiteralPath $MyInvocation.MyCommand.Definition
