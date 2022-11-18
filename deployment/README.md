The deployment folder contains the following:

 - configData.zip: a zip file that was exported from a Power Platform environment
                   and contains the configuration data for the solution

 - schema.xml: the needed schema file to import the data after the solution has been imported

 - deploySAPSolution.ps: command script to import the solution and data into the necessary 
                         environment

Instructions:

 - You can either download the entire repo or just the SAPIntegrationPublicPreview.zip and deployment folder
 - Execute the ps1 script using the following syntax:

    .\deploySAPSolution.ps1 -url <url to target environment> -solutionPath <path to solution zip> 
            -configDataPath <path to configdata.zip>

The ps script should create a new authentication profile to the environment specified, then import the solution
file, and finally import the configuration data. 


 -------------------------------------------------

## Having problems? This section might contain the solution.

#### Problem:

Unable to run the powershell script because of "UnauthorizedAccess".
```
+ .\deploySAPSolution.ps1 -url https://make.powerauto....
+ ~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : SecurityError: (:) [], PSSecurityException
    + FullyQualifiedErrorId : UnauthorizedAccess
```

#### Solution
```
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

 -------------------------------------------------

#### Problem:

```
C:\...\deployment> Add-PowerAppsAccount
Add-PowerAppsAccount : The term 'Add-PowerAppsAccount' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling
of the name, or if a path was included, verify that the path is correct and try again.
At line:1 char:1
+ Add-PowerAppsAccount
+ ~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (Add-PowerAppsAccount:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException
```

#### Solution:

You need to install the [Power Platform cmdlets](https://learn.microsoft.com/en-au/power-platform/admin/powerapps-powershell#powerapps-cmdlets-for-administrators-preview).

