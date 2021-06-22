# Challenge 0: Pre-requisites - Ready, Set, GO! 

**[Home](../README.md)** - [Next Challenge >](./01-intra-forwarding.md)

## Introduction

All the elements of hack are using a predefined Terraform template to deploy the base environment. You will deploy these resources in your Azure subscription in two differents Azure regions.

At the end of this section, your base environment build looks as follows:</br>

![Firewall Architecture](images/firewall-architeture.png)

In Summary:

- Azure contains a Hub and Spoke topology in the each regions, containing a vitual machines in the spokes vNETs (Brazil South: azbrsouthvm01, azbrsouthvm02 and EastUS2: azeastus2vm01) and Azure Firewall in the each hub vNET  **eastus2-hub-firewall** and **brazilsouth-hub-firewall**.
- On-Premises contain a virtual machine (onprem-mgmt-vm) and enviroment simulated by Azure Virtual Network.
- Azure Bastion is deployed in all hub VNets to enable RDP and SSH connection.
- All of the workloads is deployed within a resource group called: *wth-azurefirewall-rg*.

## Description

In this challenge we'll be setting up all the tools we will need to complete our challenges.

### Task 1 - Deploy the Environment

To start the terraform deployment, follow the steps listed below:

- Login to Azure Portal [https://portal.azure.com/](https://portal.azure.com/)
    - To start Azure Cloud Shell:
        - Select the Cloud Shell button on the menu bar at the upper right in the Azure portal. 

    ![Menu](images/hdi-cloud-shell-menu.png)

- Ensure you are properly logged in to your tenant and with a subscription selected for Azure. You can check that by using:

```azure cli
az account list --output table
az account set --subscription "My Subscription"
```

- Clone the following GitHub repository 

```azure cli
git clone https://github.com/adicout/microhack/
```

- Go to the folder students/terraform and initialize the terraform modules and download the azurerm resource provider

```azure cli
terraform init
```

- Now run apply to start the deployment (When prompted, confirm with a **yes** to start the deployment)

```azure cli
terraform apply
```

- Wait for the deployment to complete. This will take around 30 minutes (the VPN gateways, Azure Firewall take a while).

### Task 2 - Explore and verify the deployed resources

After the Terraform deployment concludes successfully, verify if the resources have been implemented.

- Login to Azure Portal [https://portal.azure.com/](https://portal.azure.com/)
    - To start Azure Cloud Shell:
        - Select the Cloud Shell button on the menu bar at the upper right in the Azure portal. 

    ![Menu](images/hdi-cloud-shell-menu.png)

```azure cli
az resource list --name firewall-microhack-rg
```
Verify if you can access all four virtual machines via Azure Bastion, using the following information:

- *Username: azureadmin*</br>
- *Password: HackP@ssw0rd* 

### Task 3 - Create a Log Analytics Workspace

As part of the Microhack you will require to create a workspace in the log Analytics to sent the Azure Firewall diagnostic logs. 

1. Login to Azure Portal [https://portal.azure.com/](https://portal.azure.com/)
    - To start Azure Cloud Shell:
        - Select the Cloud Shell button on the menu bar at the upper right in the Azure portal. ->

    ![Menu](images/hdi-cloud-shell-menu.png)

2. Run the follow command: 

```azure cli
az monitor log-analytics workspace create -g firewall-microhack-rg  -n azurenetworkmonitor 
```
:exclamation: In workspace name **Enter Unique Name all lowercase**

2. Validate if **Log Analytics** created in the Azure Portal, under the Log Analytics Workspace.

``` Azure CLI
az monitor log-analytics workspace list -g firewall-microhack-rg  --output table
```

:point_right: Check on the Azure portal under the resource group if the resource is created.
### Task 4: Enable diagnostic logging for Azure Firewall

1. In the Azure portal, open the Azure Cloud Shell:

    - Select the Cloud Shell button on the menu bar at the upper right in the Azure portal. 

    ![](./images/hdi-cloud-shell-menu.png)

2. Run the follow command: 

```azure cli
az monitor diagnostic-settings create -n 'toLogAnalytics'
   --resource '/subscriptions/<subscriptionId>/resourceGroups/firewall-microhack-rg/providers/Microsoft.Network/azureFirewalls/brazilsouth-hub-firewall'
   --workspace '/subscriptions/<subscriptionId>/resourceGroups/firewall-microhack-rg/providers/microsoft.operationalinsights/workspaces/<workspace name>'
   --logs '[{\"category\":\"AzureFirewallApplicationRule\",\"Enabled\":true}, {\"category\":\"AzureFirewallNetworkRule\",\"Enabled\":true}, {\"category\":\"AzureFirewallDnsProxy\",\"Enabled\":true}]' 
   --metrics '[{\"category\": \"AllMetrics\",\"enabled\": true}]'
```
3. Verify if **diagnostic settings** created in the Azure Portal>Firewall, Under Monitoring, select Diagnostic settings.

:point_right: Repeat at the same steps 2 and 3 for **eastus2-hub-firewall**


## Success Criteria

1. You have a bash shell at your disposal (WSL, Mac, Linux or Azure Cloud Shell)
1. Running `az --version` shows the version of your Azure CLI
1. Visual Studio Code is installed.
