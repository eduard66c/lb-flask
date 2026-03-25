Set-Location $PSScriptRoot

# Load variables from .env
if (Test-Path .env) {
    foreach ($line in Get-Content .env) {
        if ($line -match "^[^#].*=") {
            $name, $value = $line -split '=', 2
            $env:$name = $value
        }
    }
}

# Check if required variables are set
if (-not $env:PROJECT_ID -or -not $env:GITHUB_REPO) {
    Write-Error "Error: PROJECT_ID and GITHUB_REPO must be set in .env"
    exit 1
}

$Region = if ($env:REGION) { $env:REGION } else { "europe-west1" }

Set-Location "$PSScriptRoot/../terraform"
terraform init
terraform apply -target=module.identity `
  -var="project_id=$($env:PROJECT_ID)" `
  -var="region=$Region" `
  -var="github_repo=$($env:GITHUB_REPO)"
