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
pac auth select --name TempProfile

# import solution
pac solution import --path $solutionPath --publish-changes 

# import config data 
pac data import --data $configDataPath --environment $url

# clean up authentication profile
pac auth delete --name TempProfile