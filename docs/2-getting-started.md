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

TODO: Add instructions how to setup VS Code with SSH key for ease of use. 


# Spin up the enablement environment with the k8s cluster

### Prepare Host
```bash
source .devcontainer/util/source_framework.sh && checkHost
```

Type yes to install all requirements for the framework.


### Get Dynakube and Tokens 

Go to the Kubernetes App in your Dynatrace environment


Select:

- Other distributions
- Enable Log management and analytics
- Enable Extensions
- Enable Telemetry endpoints for data ingestremotete
- Give the cluster a name  `remote-environment`
- For Networkzone and Hostgroup give also a name `remote-environment`

![Add Kubernetes cluster](img/monitork8s.png)

- Generate a Dynatrace Operator token and a Data Ingest token 
    - ⚠️ Copy and save both Tokens in your Clipboard!

![Dynakube Tokens](img/dynakube_tokens.png)

!!! important "Save Tokens to your Clipboard 📋"
	Save the Operator Token and Data Ingest Token to your clipboard

- 💾 Download the `Dynakube.yaml`file


### Set the environment variables

**Set up secrets and environment variables**

Go back to the server and create an .env file in `.devcontainer/runlocal/.env`

!!! info "Sample `.env` file"
	You can copy and paste the following sample into `.devcontainer/runlocal/.env`. Your environment file should look similar to this:

	```properties title=".devcontainer/runlocal/.env" linenums="1"
	# Environment variables as defined as secrets in the devcontainer.json file
	# Dynatrace Tenant
	DT_ENVIRONMENT=https://abc123.sprint.apps.dynatracelabs.com
		
    # Dynatrace Operator Token
	DT_OPERATOR_TOKEN=dt0c01.XXXXXX

	# Dynatrace Ingest Token
	DT_INGEST_TOKEN=dt0c01.YYYYYY

	```


### Start the enablement environment

We are ready to start the environment, go to the .devcontainer folder and start the container.

```bash
cd .devcontainer
make start
```

`make start` will either start the environment or attach a new shell to the container in case it is running. 


## Monitor the Kubernetes cluster


The environment has a Kubernetes cluster running. Type the following commands to get a quick overview of whats running inside.

```bash
# List the nodes
kubectl get nodes -o wide

# List the ressources
kubectl get all -A

```

You'll notice this is a single node cluster (kind) and it has the minimum kubernetes services such as etcd, api-server, scheduler and proxy running on it. 


### Install the Dynatrace Operator

We install the Dynatrace Operator using HELM as in the instructions or wizard.

```bash
helm install dynatrace-operator oci://public.ecr.aws/dynatrace/dynatrace-operator \
--create-namespace \
--namespace dynatrace \
--atomic
```

### Deploy the Dynakube with Cloud Native FullStack

Copy and paste the dynakube file to the server.




<div class="grid cards" markdown>
- [Let's launch Codespaces:octicons-arrow-right-24:](3-content.md)
</div>
