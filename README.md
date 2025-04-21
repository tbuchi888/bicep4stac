# bicep4stac
This is a repository containing sample Bicep code for creating a Storage Account by interactively entering some input parameters during the execution of the `az deployment group create` command on an existing resource group. 

Below is an example of the execution result.
```
# az deployment group create --resource-group demo-bicep-stac01 --template-file main.bicep
Please provide string value for 'storageAccountName' (? for help): stac7878989
Please provide string value for 'storageAccountType' (? for help): 
 [1] Standard_LRS
 [2] Standard_ZRS
 [3] Standard_GRS
 [4] Standard_GZRS
 [5] Standard_RAGRS
 [6] Standard_RAGZRS
Please enter a choice [Default choice(1)]: 2
Please provide bool value for 'isHnsEnabled' (? for help): 
 [1] True
 [2] False
Please enter a choice [Default choice(1)]: 2
Please provide string value for 'accessTier' (? for help): 
 [1] Hot
 [2] Cool
Please enter a choice [Default choice(1)]: 1
Please provide bool value for 'deleteRetentionPolicyEnabled' (? for help): 
 [1] True
 [2] False
Please enter a choice [Default choice(1)]: 1
Please provide int value for 'deleteRetentionPolicyDays' (? for help): 7
Please provide bool value for 'containerDeleteRetentionPolicyEnabled' (? for help): 
 [1] True
 [2] False
Please enter a choice [Default choice(1)]: 1
Please provide int value for 'containerDeleteRetentionPolicyDays' (? for help): 7
```

Please follow the link provided below.
https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install
https://learn.microsoft.com/en-us/azure/templates/microsoft.storage/storageaccounts?pivots=deployment-language-bicep
