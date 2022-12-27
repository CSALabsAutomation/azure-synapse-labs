param(
    [string] $ResourceGroupName,
    [string] $StorageAccountName
)

Write-Host "File uploading...."
Write-Host "RG: $($ResourceGroupName) | SA: $($StorageAccountName)"


 if ((Get-Module -ListAvailable Az.Accounts) -eq $null)
	{
       Install-Module -Name Az.Accounts -Force
    }
Write-Host "Az Account installed...."
try {  
  


$uri = "https://raw.githubusercontent.com/CSALabsAutomation/azure-synapse-labs/main/environments/env1/Sample/Artifacts/TaxiDataFiles/Geography.csv";
$bacpacFileName = "Geography.csv";

$storageaccountkey = Get-AzStorageAccountKey -ResourceGroupName $ResourceGroupName -Name $StorageAccountName;

$ctx = New-AzStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $storageaccountkey.Value[0]

Invoke-WebRequest -Uri $uri -OutFile $bacpacFileName 
Set-AzStorageBlobContent -File $bacpacFileName -Container "fr-assets" -Blob 'Geography.csv' -Context $ctx
}
catch {
    Write-Host 'Something went wrong'
    Write-Host $_
}

