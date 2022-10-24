# capture parameters
param( [Parameter(Mandatory=$true)] $url,
       [Parameter(Mandatory=$true)] $solutionPath,
       [Parameter(Mandatory=$true)] $configDataPath)

# validate all required params exist
# we aren't checking validity here; just existence
if( ([string]::IsNullOrEmpty($url)) -or ([string]::IsNullOrEmpty($solutionPath)) -or 
    ([string]::IsNullOrEmpty($configDataPath)))
{
    write-host "One or more required parameters are missing";
    exit;
}

# create and select authentication profile
pac auth create --url $url --name TempProfile
$authSelected = pac auth select --name TempProfile

# store environment url for later use
$authSelected[1] -match "\.*\s(?<Url>https:\/\/\S*)\s"
$envUrl = $Matches.Url

# import solution
pac solution import --path $solutionPath --publish-changes 

# import config data 
pac data import --data $configDataPath --environment $url

# clean up authentication profile
pac auth delete --name TempProfile

# enable all cloud flows
$flowdisplaynames = @('ApprovePurchaseOrder','CreateAttachment','CreateGoodsReceipt','CreatePurchaseOrder','CreateSalesOrder','CreateVendorInvoice','DeleteAttachment','ReadAttachmentList',
            'ReadCustomer','ReadCustomerList','ReadMaterial','ReadMaterialList','ReadPurchaseOrder','ReadPurchaseOrderList','ReadSalesOrder','ReadSalesOrderList','ReadVendor',
            'ReadVendorList','UpdatePurchaseOrder','UpdateSalesOrder')

# sign into tenant and get target environment
Add-PowerAppsAccount

$allenvs = Get-AdminPowerAppEnvironment
$env = $allenvs | Where-Object -FilterScript { $_.Internal.properties.linkedEnvironmentMetadata.instanceUrl -eq $envUrl }

# iterate through flows and enable
$allflows = Get-AdminFlow -EnvironmentName $env.EnvironmentName
$flows = $allflows | where-object -FilterScript { $_.DisplayName -in $flowdisplaynames }

$flows | Enable-AdminFlow -EnvironmentName $env.EnvironmentName | Out-Null