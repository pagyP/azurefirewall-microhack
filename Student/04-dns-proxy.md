# Challenge 3: Enable the DNS Proxy

[< Previous Challenge](./00-prereqs.md) - **[Home](../README.md)** - [Next Challenge >](./02-acr.md)

## Introduction

In this challenge, you will set up DNS queries coming from the virtual machines to the Azure Firewall that will act as DNS Proxy.


## Description
You will set up the DNS Proxy through the Azure Firewall, and when virtual machines try to resolve domain names, the first step these requests will be following to Firewall base on virtual network DNS settings. 

#### Task 1 - Setup DNS Proxy

To start the setup, follow the steps listed below:

1. Login to Azure Portal [https://portal.azure.com/](https://portal.azure.com/)
    - To start Azure Cloud Shell:
        - Select the Cloud Shell button on the menu bar at the upper right in the Azure portal. 

    ![Menu](images/hdi-cloud-shell-menu.png)

2. Ensure you are properly logged in to your tenant and with a subscription selected for Azure. You can check that by using:

```azure cli
az account list --output table
az account set --subscription "My Subscription"
```

- Create an application rules trought Firewall Policy  **azfw-policy-std**

```bash
az network firewall policy rule-collection-group collection add-filter-collection -g wth-azurefirewall-rg --policy-name azfw-policy-std --rule-collection-group-name DefaultApplicationRuleCollectionGroup --name rule-allow-site-threat-intell --action Allow --rule-name allow-site-threat-intell --rule-type ApplicationRule --source-addresses "10.20.1.4" --protocols Http=80 --target-fqdns testmaliciousdomain.eastus.cloudapp.azure.com --collection-priority 11100
```

Connect to **azbrazilsouthvm01 - 10.20.1.4** via Bastion, open the command prompt and execute it:

```cmd
curl testmaliciousdomain.eastus.cloudapp.azure.com
```

:notebook_with_decorative_cover:To help test outbound alerts are working, a test FQDN has been created that triggers an alert. Use testmaliciousdomain.eastus.cloudapp.azure.com for your outbound tests.


:question: What is the behavior, after you execute the curl command?

You can verify if it triggers an alert in the Azure Log Analytics. You can use the below Kusto Query:

```bash
AzureDiagnostics
| where OperationName  == "AzureFirewallThreatIntelLog"
| parse msg_s with Protocol " request from " SourceIP ":" SourcePortInt:int " to " TargetIP ":" TargetPortInt:int *
| parse msg_s with * ". Action: " Action "." Message
| parse msg_s with Protocol2 " request from " SourceIP2 " to " TargetIP2 ". Action: " Action2
| extend SourcePort = tostring(SourcePortInt),TargetPort = tostring(TargetPortInt)
| extend Protocol = case(Protocol == "", Protocol2, Protocol),SourceIP = case(SourceIP == "", SourceIP2, SourceIP),TargetIP = case(TargetIP == "", TargetIP2, TargetIP),SourcePort = case(SourcePort == "", "N/A", SourcePort),TargetPort = case(TargetPort == "", "N/A", TargetPort)
| sort by TimeGenerated desc 
| project TimeGenerated, msg_s, Protocol, SourceIP,SourcePort,TargetIP,TargetPort,Action,Message
```

![Azure Log Analytics](images/Firewall-Thread-Intell.PNG)

#### Task 2 - Deny malicius domain in yhe threat intelligence mode

Follow the steps 1 and 2 of **Task 1** and run it Az cli command.

```bash
az network firewall policy update --name azfw-policy-std -g wth-azurefirewall-rg --threat-intel-mode Deny --sku Premium
```
Connect to **azbrazilsouthvm01 - 10.20.1.4** via Bastion, open the command prompt and execute it:

```cmd
curl testmaliciousdomain.eastus.cloudapp.azure.com
```

:question: What is the result?

![Azure Log Analytics](images/Firewall-Thread-Intell-Deny.PNG)

## Success Criteria

1. You can reach out the virtual machine in eastus2 region and local datacenter.
2. You have updated 5 route tables for complete it.
3. You can run ping tool to test the connection between virtual machines.

## Learning Resources

- [Virtual network traffic routing ](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-udr-overview)</br>
- [Azure Firewall rule processing logic ](https://docs.microsoft.com/en-us/azure/firewall-manager/rule-processing)</br>
- [Azure Firewall Manager policy overview ](https://docs.microsoft.com/en-us/azure/firewall-manager/policy-overview)</br>
- [Deploy and configure Azure Firewall and policy using the Azure portal ](https://docs.microsoft.com/en-us/azure/firewall/tutorial-firewall-deploy-portal-policy)</br>
- [IP Groups in Azure Firewall ](https://docs.microsoft.com/bs-latn-ba/azure/firewall/ip-groups)
