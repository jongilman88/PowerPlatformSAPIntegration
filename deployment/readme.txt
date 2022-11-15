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
