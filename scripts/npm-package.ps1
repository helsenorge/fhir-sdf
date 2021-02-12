$packagefolder = "out/json"
$packagename = "@helsenorge/fhir-sdf"
$license = "MIT"
$packagefile = "package.json"
$versionfile = "../../version.txt"

# Check that json files exists
If (!(test-path $packagefolder)) {
  Write-Host "The package folder was not found. Convert files first!"
  exit 1
}

# Initialize package.json if it does not exist
Set-Location $packagefolder
If (!(Test-Path $packagefile)) {
  & npm init -y
}
$version = Get-Content $versionfile -First 1
if (!($version -match '^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-((?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\+([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?$')) {
  Write-Host "Could not read valid version from version.txt"
  exit 1
}

# Set package definition
$package = Get-Content $packagefile -raw | ConvertFrom-Json
$package.name = [string]$packagename
$package.version = [string]$version
$package.license = $license
$package | ConvertTo-Json | Set-Content $packagefile
