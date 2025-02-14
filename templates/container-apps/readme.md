# 📦🌐 Azure Container Apps

![](https://i.imgur.com/waxVImv.png)
### [View all Roadmaps](https://github.com/nholuongut/all-roadmaps) &nbsp;&middot;&nbsp; [Best Practices](https://github.com/nholuongut/all-roadmaps/blob/main/public/best-practices/) &nbsp;&middot;&nbsp; [Questions](https://www.linkedin.com/in/nholuong/)
<br/>

There are three templates in this directory

- simple.bicep
- wordpress-vnet.bicep
- keycloak-vnet.bicep - NOTE: WIP, lacking the first time database creation in MS-SQL

> NOTE: April 2022 - Currently Azure Container Apps are only available in a very small set of regions

## 📜 Wordpress VNet

Wordpress is old and crummy, but it provides a good example of application that requires a backend DB, needs to handle configuration that is passed from one resource to another (e.g. passwords and hostnames), and has a public front end. As such it presents a nice use case for Container Apps, and is indicative of the deployment of many other systems, e.g:

- Placing Container Apps into a VNet to access other resources privately
- Creating a VNET & subnets for use with Container Apps
- Deploying Container Apps on both TCP and HTTPs 

### Quick Deploy

Deploy as a subscription level deployment using the Azure CLI, taking the defaults:

```bash
az deployment sub create --template-file ./wordpress-vnet.bicep --location westeurope
```

## 📜 Simple

This deploys a single container using the [Azure Container App service](https://docs.microsoft.com/en-gb/azure/container-apps/overview). You can use this as a template or starting point for deploying any container

### Parameters

| Name     | Description                                                           | Type   | Default                               |
| -------- | --------------------------------------------------------------------- | ------ | ------------------------------------- |
| name     | Name used for resource group, and base name for container & resources | string | _none_                                |
| location | Azure region for all resources                                        | string | _Same as deployment_                  |
| image    | Image to deploy                                                       | string | ghcr.io/nholuongut-devops/nodejs-demoapp:latest |
| port     | Port the image listens on                                             | int    | 3000                                  |

### Quick Deploy

Deploy as a subscription level deployment using the Azure CLI, taking the defaults:

```bash
az deployment sub create --template-file ./simple.bicep \
  --location westeurope \
  --parameters appName="my-demo-app"
```

## 📜 Custom Domain

Similar to the simple template, except this sets up a custom domain name and also DNS records for the domain.

You must have an existing public Azure DNS zone deployed and working

Before deploying, you must create a self signed cert, as follows. Change the DOMAIN to the FQDN you intend to deploy to.

```bash
DNS_NAME=myapp
DNS_ZONE=example.net
FQDN=${DNS_NAME}.${DNS_ZONE}
openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes \
  -keyout cert.key -out cert.pem -subj "/CN=$FQDN" \
  -addext "subjectAltName=DNS:$FQDN"
openssl pkcs12 -export -out cert.p12 -inkey cert.key -in cert.pem
```

### Parameters

| Name            | Description                                                           | Type   | Default                               |
| --------------- | --------------------------------------------------------------------- | ------ | ------------------------------------- |
| name            | Name used for resource group, and base name for container & resources | string | _none_                                |
| location        | Azure region for all resources                                        | string | _Same as deployment_                  |
| image           | Image to deploy                                                       | string | ghcr.io/nholuongut-devops/nodejs-demoapp:latest |
| port            | Port the image listens on                                             | int    | 3000                                  |
| domainPrefix    | Domain name for the app, will create a DNS record                     | string | _none_                                |
| dnsZone         | DNS zone to configure, must already exist                             | string | _none_                                |
| dnsZoneResGroup | Resource group holding the DNS zone                                   | string | _none_                                |

> NOTE: If your FQDN was `myapp.example.net` then you would set `domainPrefix=myapp` and `dnsZone=example.net`
 
### Quick Deploy

Deploy as a subscription level deployment using the Azure CLI:

```bash
az deployment sub create --template-file ./custom-domain.bicep \
  --location westeurope \
  --parameters appName="my-demo-app" \
  domainPrefix=$DNS_NAME \
  dnsZone=$DNS_ZONE \
  dnsZoneResGroup="dns-resgrp"
```

![](https://i.imgur.com/waxVImv.png)
# 🚀 I'm are always open to your feedback.  Please contact as bellow information:
### [Contact Me]
* [Name: Nho Luong]
* [Skype](luongutnho_skype)
* [Github](https://github.com/nholuongut/)
* [Linkedin](https://www.linkedin.com/in/nholuong/)
* [Email Address](luongutnho@hotmail.com)
* [PayPal.me](https://www.paypal.com/paypalme/nholuongut)

![](https://i.imgur.com/waxVImv.png)
![](Donate.png)
[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/nholuong)

# License
* Nho Luong (c). All Rights Reserved.🌟