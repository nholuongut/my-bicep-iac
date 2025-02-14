# 🐄 RKE2 Bicep Template


![](https://i.imgur.com/waxVImv.png)
### [View all Roadmaps](https://github.com/nholuongut/all-roadmaps) &nbsp;&middot;&nbsp; [Best Practices](https://github.com/nholuongut/all-roadmaps/blob/main/public/best-practices/) &nbsp;&middot;&nbsp; [Questions](https://www.linkedin.com/in/nholuong/)
<br/>
Deploys a RKE2 cluster to Azure on Ubuntu 20.04

- Multiple agent nodes
- Automatic configuration of the [Azure Cloud Provider](https://kubernetes-sigs.github.io/cloud-provider-azure/) using in-tree provider
- Sets up default storage class for Azure
- Taints the server nodes
- Works in Azure Public and Azure US Government 
- Sets TLS-SAN to external hostname so api-server can be accessed remotely
- Labels agent nodes correctly so PVCs etc can be mounted
- Configuring Linux kernel parameters (vm.max_map_count=262144)

## Quick Deploy

Run from the rke2 directory, i.e. `cd rke2`

Using your SSH key as a means to login to the server node

```bash
az deployment sub create --template-file main.bicep \
--location uksouth \
--parameters resGroupName="rke2" \
  location="uksouth" \
  authString="$(cat ~/.ssh/id_rsa.pub)"
```

Or use a password

```bash
az deployment sub create --template-file main.bicep \
--location uksouth \
--parameters resGroupName="rke2" \
  location="uksouth" \
  authType="password" \
  authString="Password@123!"
```

Deploy into a Azure Gov Cloud

```bash
az deployment sub create --template-file main.bicep \
--location usdodcentral \
--parameters resGroupName=rke2-gov \
  location="usdodcentral" \
  cloudName="AzureUSGovernmentCloud" \
  authString="$(cat ~/.ssh/id_rsa.pub)"
```

## Connecting to RKE2 Cluster

Connect to the server and copy the kube config to your local machine

```bash
rke2Server=$(az deployment sub show --name main --query "properties.outputs.serverFQDN.value" -o tsv)
scp azureuser@${rke2Server}:/etc/rancher/rke2/rke2.yaml $HOME/rke2-kubeconfig
```

Update the config so the server address is the remote DNS name, not localhost

```bash
sed -i "s/127.0.0.1/$rke2Server/" $HOME/rke2-kubeconfig
```

Set your KUBECONFIG to use this file and run kubectl commands against the RKE2 cluster

```bash
export KUBECONFIG=$HOME/rke2-kubeconfig
kubectl get no
```

> Note. You may get permission denied when copying the rke2.yaml file, if so wait and try again

## Parameters

| Name         | Purpose                                                  | Default          | Type   |
| ------------ | -------------------------------------------------------- | ---------------- | ------ |
| resGroupName | Resource group to deploy to, will be created             | NONE             | string |
| location     | Azure region to use                                      | NONE             | string |
| suffix       | Resource name suffix appended to all resources           | `rke2`           | string |
| authString   | Password or SSH public key                               | NONE             | string |
| authType     | Either `publicKey` or `password`                         | `publicKey`      | string |
| agentCount   | Number of agent nodes                                    | 3                | int    |
| serverVMSize | VM size for server node(s)                               | `Standard_D8_v3` | string |
| agentVMSize  | VM size for agent node(s)                                | `Standard_D8_v3` | string |
| cloudName    | Azure cloud to use; AzureUSGovernmentCloud or AzurePublic | `AzurePublic`    | string |

## Outputs

- serverIP
- serverFQDN

# Known Issues / Roadmap

- Uses standard VMs
- No HA for the server

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