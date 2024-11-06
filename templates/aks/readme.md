# 📦🌐 Azure Kubernetes Service

![](https://i.imgur.com/waxVImv.png)
### [View all Roadmaps](https://github.com/nholuongut/all-roadmaps) &nbsp;&middot;&nbsp; [Best Practices](https://github.com/nholuongut/all-roadmaps/blob/main/public/best-practices/) &nbsp;&middot;&nbsp; [Questions](https://www.linkedin.com/in/nholuong/)
<br/>

This deploys a AKS cluster, with the following features:

- Cluster autoscaler
- CNI networking mode with VNet
- Container Insights with Log Analytics

## Parameters

| Name             | Description                                                    | Type   | Default              |
| ---------------- | -------------------------------------------------------------- | ------ | -------------------- |
| clusterName      | Name used for resource group and base name cluster & resources | string | _none_               |
| location         | Azure region for all resources                                 | string | _Same as deployment_ |
| enableMonitoring | Image to deploy                                                | bool   | _true_               |
| clusterConfig    | Configuration of AKS, see below                                | object | _true_               |

## Cluster Config

The clusterConfig parameter is an object with the following default properties:

```text
{
  version:      '1.21.2'
  nodeSize:     'Standard_D4s_v4'
  nodeCount:    1
  nodeCountMax: 10
}
```

## Quick Deploy

To quickly deploy taking the defaults:

```bash
az deployment sub create --template-file ./main.bicep \
  --location uksouth \
  --parameters clusterName="my-aks"
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