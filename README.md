
# Azure DevOps Pipelines agents for Microsoft Stacks

This repository contains the source code for the
[Azure DevOps Pipelines agents](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/agents?view=azure-devops)
with Open Source Software installed. This project is derived from the official
GitHub Actions runners project, which is available at
[github.com/actions/runner-images](https://github.com/actions/runner-images).

## Project goals

The goal of this project is to provide a set of Azure DevOps Pipelines agents
with all Open Source Software installed to build and run most Microsoft based
projects. The agents are based on the official GitHub Actions runners, which
have been stripped of all software with proprietary licenses. The agents are
available for Ubuntu 22.04 initially and a Windows 2022 version is planned.

## Agent Image Distribution

You can either build the agent images yourself or use the pre-built images from
the Community Compute Gallery in Azure and the Azure Marketplace.

## Using the pre-built agent images from Azure Marketplace

To use the Pre-built agent images from [Azure Marketplace](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/rtbusinessvalidation1685730553911.ado-agent-ms-stack-ubuntu2204?tab=Overview),
you need to create a resource group in Azure and then deploy the agent image to
a virtual machine scale set in the resource group. The following *Azure CLI*
commands will create the resource group and deploy the *Ubuntu 2204* agent image
to a virtual machine scale set named `vmss-ado-ms-stack-ubuntu2204` in the
resource group `rg-devops-scalesets-weu` in the *westeurope* region:

```bash
# Create a resource group
az group create --name rg-devops-scalesets-weu --location westeurope
# Accept the terms for the agent image
az vm image terms accept \
--urn rtbusinessvalidation1685730553911:ado-agent-ms-stack-ubuntu2204:ado-agent-ms-stack-ubuntu2204:latest
# Create the VM scale set using a Standard_D2_v3 VM size
az vmss create \
 --name vmss-ado-ms-stack-ubuntu2204 \
 --resource-group rg-devops-scalesets-weu \
 --image rtbusinessvalidation1685730553911:ado-agent-ms-stack-ubuntu2204:ado-agent-ms-stack-ubuntu2204:latest \
 --vm-sku Standard_D2_v3 \
 --storage-sku StandardSSD_LRS \
 --authentication-type SSH \
 --generate-ssh-keys \
 --instance-count 2 \
 --disable-overprovision \
 --upgrade-policy-mode manual \
 --single-placement-group false \
 --platform-fault-domain-count 1 \
 --load-balancer '' --admin-username devopsuser
```

Then you need to create the agent pool in Azure DevOps and configure the
connection between the agent pool and the virtual machine scale set as detailed
in the [Azure DevOps documentation](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/scale-set-agents?view=azure-devops#create-the-scale-set-agent-pool).

## Building the agent images

The agent images are built using [Packer](https://packer.io) and the build
scripts are written in PowerShell. The build scripts are located in the
`images` folder. The build scripts are designed to be run in Azure DevOps or
GitHub Actions, but can also be run locally.
