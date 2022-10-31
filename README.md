# EMPC BR Terraform Modules
Repository to reusable modules for projects in EMPC. 

## Cloud Providers availables
---
- [Azure](./azure/)

## Deploy a example module to Azure
---
```bash
$ cd ./azure
$ make validate-and-plan
$ make apply
```

## Destroy a example module to Azure
---
```bash
$ make plan-destroy
$ make destroy
```