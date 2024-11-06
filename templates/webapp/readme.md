# ☁️🌐 Azure App Service - Web App

![](https://i.imgur.com/waxVImv.png)
### [View all Roadmaps](https://github.com/nholuongut/all-roadmaps) &nbsp;&middot;&nbsp; [Best Practices](https://github.com/nholuongut/all-roadmaps/blob/main/public/best-practices/) &nbsp;&middot;&nbsp; [Questions](https://www.linkedin.com/in/nholuong/)
<br/>

Pretty standard deployment of Azure App Service + Web App

## Parameters

| Name              | Description                                                | Type   | Default                |
| ----------------- | ---------------------------------------------------------- | ------ | ---------------------- |
| appName           | Name used for resource group and webapp name               | string | _none_                 |
| location          | Azure region for all resources                             | string | _Same as deployment_   |
| existingSvcPlanId | Existing App Service Plan, leave blank to create a new one | bool   | _true_                 |
| registry          | Registry holding the image to deploy                       | string | ghcr.io                |
| imageRepo         | Name of the repo & image to be deployed                    | string | nholuongut-devops/nodejs-demoapp |

## Quick Deploy

To quickly deploy taking the defaults:

```bash
az deployment sub create --template-file ./main.bicep \
  --location uksouth \
  --parameters appName="my-web-app"
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
