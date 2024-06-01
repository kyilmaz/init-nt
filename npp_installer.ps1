# Set TLS support for Powershell and parse the JSON request
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$npp = Invoke-WebRequest -UseBasicParsing 'https://api.github.com/repos/notepad-plus-plus/notepad-plus-plus/releases/latest' | ConvertFrom-Json

# Get the download URL from the JSON object
$dlUrl = $npp.assets[2].browser_download_url 

# Get the file name
$outfile = $npp.assets[2].name

# Get the current directory and build the installer path
$cwd = (Get-Location).Path 
$installerPath = Join-Path $cwd $outfile

Write-Host "Silently Installing $($npp.name)... Please wait..."

# Start the download and save the file to the installerpath
Invoke-WebRequest -UseBasicParsing $dlUrl -OutFile $installerPath

# Silently install NotepadPlusPlus then remove the downloaded item
Start-Process -FilePath $installerPath -Args "/S" -Verb RunAs -Wait
Remove-Item $installerPath



