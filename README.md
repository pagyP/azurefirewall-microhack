# What The Hack - Protect your workloads with Azure Firewall Premium
## Introduction
The adoption of Internet use throughout the business world has boosted network usage in general. Companies are using various network security measures such as firewalls, intrusion detection systems (IDS), intrusion prevention systems (IPS) to protect their networks (even for cloud computing), which are the preferred targets of threat actors for compromising organizations’ security. The Azure Firewall is a managed, cloud-based network security service that protects your resources inside the virtual network. You will engage in a complex Azure Network security setup using the Azure Firewall to complete the challenges in these WTH exercises. You will set up rules for Network, Application, IDPs, TLS Inspection and Web Categories.

This hack includes a optional [lecture presentation](Coach/Lectures.pptx) that features short presentations to introduce key topics associated with Azure Firewall Premium. It is recommended that the host present each short presentation before attendees kick off that challenge.

## Learning Objectives

After completing this Hack you will be able to:

- How to implement Azure Firewall and Firewall Manager to control hybrid and cross-virtual network traffic.
- How to implement the Azure Sentinel to monitoring and generated security incident alerts.
- How to detect malicious network attack.
- How to set up policies rules on Azure Firewall Premium.

## Challenges
- Challenge 0: **[Prerequisites!](Student/00-prereqs.md)**
   - Prepare your enviroment on Azure with terraform and Az Cli code.
- Challenge 1: **[Intra-region Forwarding](Student/01-intra-forwarding.md)**
   - Package the "FabMedical" app into a Docker container and run it locally.
- Challenge 2: **[Inter-region Forwarding](Student/02-acr.md)**
   - Deploy an Azure Container Registry, secure it and publish your container.
- Challenge 3: **[Introduction To Kubernetes](Student/03-k8sintro.md)**
   - Install the Kubernetes CLI tool, deploy an AKS cluster in Azure, and verify it is running.
- Challenge 4: **[Your First Deployment](Student/04-k8sdeployment.md)**
   - Pods, Services, Deployments: Getting your YAML on! Deploy the "FabMedical" app to your AKS cluster. 
- Challenge 5: **[Scaling and High Availability](Student/05-scaling.md)**
   - Flex Kubernetes' muscles by scaling pods, and then nodes. Observe how Kubernetes responds to resource limits.
- Challenge 6: **[Deploy MongoDB to AKS](Student/06-deploymongo.md)**
   - Deploy MongoDB to AKS from a public container registry.
- Challenge 7: **[Updates and Rollbacks](Student/07-updaterollback.md)**
   - Deploy v2 of FabMedical to AKS via rolling updates, roll it back, then deploy it again using the blue/green deployment methodology.
- Challenge 8: **[Storage](Student/08-storage.md)**
   - Delete the MongoDB you created earlier and observe what happens when you don't have persistent storage. Fix it!
- Challenge 9: **[Helm](Student/09-helm.md)**
   - Install Helm tools, customize a sample Helm package to deploy FabMedical, publish the Helm package to Azure Container Registry and use the Helm package to redeploy FabMedical to AKS.
- Challenge 10: **[Networking](Student/10-networking.md)**
   - Explore integrating DNS with Kubernetes services and explore different ways of routing traffic to FabMedical by configuring an Ingress Controller.
- Challenge 11: **[Operations and Monitoring](Student/11-opsmonitoring.md)**
   - Explore the logs provided by Kubernetes using the Kubernetes CLI, configure Azure Monitor and build a dashboard that monitors your AKS cluster
   
## Prerequisites

The purpose of this Hack is to build an understanding of the use of Azure Firewall with a focus on the network and security capabilities recently introduced. Consider the following articles required as pre-reading to build a foundation of knowledge.

[Azure Network Security Ninja Training ](https://techcommunity.microsoft.com/t5/azure-network-security/azure-network-security-ninja-training/ba-p/2356101)
   - Check out the **1.2.2 Azure Firewall and Azure Firewall Manager**


## Repository Contents
- `../Coach/Guides`
  - [Lecture presentation](Coach/Lectures.pptx) with short presentations to introduce the Azure Firewall.
- `../Coach/Solutions`
   - Example solutions to the challenges (If you're a student, don't cheat yourself out of an education!)
- `../Student/Resources`
   - Terraform code to build the enviroment and sample templates to aid with challenges.

## Contributors
- Adilson Coutrin
- Flavio Honda
