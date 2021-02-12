folder = "out/json"

$folders = Get-ChildItem -Path "resources" -directory

# Check that output folder exists
If (!(test-path $outfolder)) {
  New-Item -ItemType Directory -Force -Path $outfolder
}

# Install or upgrade fhir-tool
& dotnet tool update fhir-tool -g

# Loop through folders and convert files to json
foreach ($folder in $folders) {
  Write-Host "`r`nFolder" $folder.Name...
  New-Item -ItemType Directory -Force -Path $outfolder -Name $folder.Name | Out-Null

  $outputdir = Join-Path $outfolder -ChildPath $folder.Name | Resolve-Path

  $files = Get-ChildItem $folder
  foreach ($file in $files) {
    Write-Host "* Converting" $file.Name...
    & fhir-tool convert-format --source $file --to json --out $outputdir/
  }
}
