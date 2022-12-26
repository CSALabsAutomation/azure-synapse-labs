param(
    [string] $ResourceGroupName,
    [string] $StorageAccountName
)

Write-Host "File uploading...."
Write-Host "RG: $($ResourceGroupName) | SA: $($StorageAccountName)"

$Uri = @(
    "https://sa1ahoode.blob.core.windows.net/fr-datasets/neural-model-test-dataset/test-invoice.pdf",
    "https://sa1ahoode.blob.core.windows.net/fr-datasets/neural-model-training-dataset/invoice1.pdf",
    "https://sa1ahoode.blob.core.windows.net/fr-datasets/neural-model-training-dataset/invoice2.pdf",
    "https://sa1ahoode.blob.core.windows.net/fr-datasets/neural-model-training-dataset/invoice3.pdf",
    "https://sa1ahoode.blob.core.windows.net/fr-datasets/neural-model-training-dataset/invoice4.pdf",
    "https://sa1ahoode.blob.core.windows.net/fr-datasets/neural-model-training-dataset/invoice5.pdf",
    "https://sa1ahoode.blob.core.windows.net/fr-datasets/template-model-test-dataset/filled-form.png",
    "https://sa1ahoode.blob.core.windows.net/fr-datasets/template-model-training-dataset/form1 - Copy (2).png",
    "https://sa1ahoode.blob.core.windows.net/fr-datasets/template-model-training-dataset/form1 - Copy (3).png",
    "https://sa1ahoode.blob.core.windows.net/fr-datasets/template-model-training-dataset/form1 - Copy (4).png",
    "https://sa1ahoode.blob.core.windows.net/fr-datasets/template-model-training-dataset/form1 - Copy.png",
    "https://sa1ahoode.blob.core.windows.net/fr-datasets/template-model-training-dataset/form1.png"
);
$SrcFileName = @(
    "test-invoice.pdf",
    "invoice1.pdf",
    "invoice2.pdf",
    "invoice3.pdf",
    "invoice4.pdf",
    "invoice5.pdf",
    "filled-form.png",
    "form1 - Copy (2).png",
    "form1 - Copy (3).png",
    "form1 - Copy (4).png",
    "form1 - Copy.png",
    "form1.png"
);
$DestFileName = @(
    "neural-model-test-dataset/test-invoice.pdf",
    "neural-model-training-dataset/invoice1.pdf",
    "neural-model-training-dataset/invoice2.pdf",
    "neural-model-training-dataset/invoice3.pdf",
    "neural-model-training-dataset/invoice4.pdf",
    "neural-model-training-dataset/invoice5.pdf",
    "template-model-test-dataset/filled-form.png",
    "template-model-training-dataset/form1 - Copy (2).png",
    "template-model-training-dataset/form1 - Copy (3).png",
    "template-model-training-dataset/form1 - Copy (4).png",
    "template-model-training-dataset/form1 - Copy.png",
    "template-model-training-dataset/form1.png"

);
$DestContainer = "fr-assets";

try {
    $StorageAccountKey = Get-AzStorageAccountKey -ResourceGroupName $ResourceGroupName -Name $StorageAccountName;
    $Ctx = New-AzStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageAccountKey.Value[0];

    For($i=0; $i -lt $Uri.Length; $i++){
        Invoke-WebRequest -Uri $Uri[$i] -OutFile $SrcFileName[$i];
        Set-AzStorageBlobContent -File $SrcFileName[$i] -Container $DestContainer -Blob $DestFileName[$i] -Context $Ctx;    
    }

    Write-Host "Files uploaded"
}
catch {
    Write-Host 'Something went wrong'
    Write-Host $_
}

