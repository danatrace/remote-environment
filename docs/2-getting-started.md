--8<-- "snippets/getting-started.js"
--8<-- "snippets/grail-requirements.md"

## 1. Prerequisistes


- Create EC2 instance
- Download VS Code

In this sections we need to download the stuff and create the ec2 instance

### 1.1 Create an EC2 Instance

- Ubuntu 24 LTS
- Memory
- CPU
- Disk
- Network policies Incomming 22, 8000, 30100, 30200, 30300
- Download SSH key


### 1.2 Download Visual Studio Code

- Go to  [https://code.visualstudio.com](https://code.visualstudio.com), download and install Visual Studio on your machine. 

!!! tip "Tipp"
    Working on a local Visual Studio Code, maximizes your productivity, you'll be able to connect to dev.containers remotely, locally, install plugins, and much more.


## Connect to instance 

- Get public IP of instance
- Add it to VS Code




# Spin up the enablement environment with the k8s cluster

### Prepare Host
```bash
source .devcontainer/util/source_framework.sh && checkHost
```

Create environment file with only the Tenant as environment variable. 

```bash
echo "DT_ENVIRONMENT=https://ydi9582h.sprint.apps.dynatracelabs.com" > .devcontainer/runlocal/.env 
```

Then we start the containers

```bash
cd .devcontainer
make start
```


## Monitor the kubernetes cluster

Go to the Kubernetes App

![Add Kubernetes cluster](img/monitork8s.png)

Select:
- Other distributions
- Enable Log management and analytics
- Enable Extensions
- Enable Telemetry endpoints for data ingest
- Give the cluster a name  `remote-environment`
- For Networkzone and Hostgroup give also a name `remote-environment`
- Generate an Operator token and a Data Ingest token
- Download the `Dynakube.yaml`file


Install the Dynatrace Operator

```bash
helm install dynatrace-operator oci://public.ecr.aws/dynatrace/dynatrace-operator \
--create-namespace \
--namespace dynatrace \
--atomic
```



<div class="grid cards" markdown>
- [Let's launch Codespaces:octicons-arrow-right-24:](3-content.md)
</div>
