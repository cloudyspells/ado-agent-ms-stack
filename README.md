
# Azure DevOps Pipelines agents for Microsoft Stacks

This repository contains the source code for the
[Azure DevOps Pipelines agents](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/agents?view=azure-devops)
with Open Source Software installed. This project is derived from the official
GitHub Actions runners project, which is available at
[github.com/actions/runner-images](https://githunb.com/actions/runner-images).

## Project goals

The goal of this project is to provide a set of Azure DevOps Pipelines agents
with all Open Source Software installed to build and run most Microsoft based
projects. The agents are based on the official GitHub Actions runners, which
have been stripped of all software with proprietary licenses. The agents are
available for Ubuntu 22.04 initially and a Windows 2022 version is planned.

## Agent Image Distribution

You can either build the agent images yourself or use the pre-built images from
the Community Compute Gallery in Azure and the Azure Marketplace. (Coming soon)

## Building the agent images

The agent images are built using [Packer](https://packer.io) and the build
scripts are written in PowerShell. The build scripts are located in the
`images` folder. The build scripts are designed to be run in Azure DevOps or
GitHub Actions, but can also be run locally.
