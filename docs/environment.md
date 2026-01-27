--8<-- "snippets/prerequisites.js"

# Prerequisites: Quick Step by Step Guide

!!! tip "Prerequisites"
    - Provision Infrastructure
    - Download Visual Studio Code

## Prerequisites
### 1.- Provision Infrastructure 

For the remote environment we'll use an EC2 Instance in the AWS cloud.

Navigate to your AWS Account and open create EC2 instance:

- Give it a name like `Sergio Hinojosa's Environment`
- Select Ubuntu as OS
- Amazon Machine Image (AMI)
    - Ubuntu Server 24.04 LTS (HVM), SSD Volume - Architecture 64-bit (x86)
- Instance Type
    - t3.xlarge (4vCPU 16 GiB Memory)
- Key pair
    - If you don't have one, create it
    - Enter key pair name
    - Type: RSA
    - Format: pem
    - Create the Identity file and download it to your computer (A good place could be something like `/Users/firstname.lastname/.aws/keys/onboarding.pem` )
- Disk
    - Allocate 40 Gig of Disk space, this should be more than enough for your onboarding journey
- Network policies Incoming 22, 8000, 30100, 30200, 30300
- Launch instance

<!-- 
t2.xlarge in Virginia Linux base 0.1856 USD
t3.xlarge in Virginia Linux base 0.1664 USD
t2.xlarge in London Linux base 0.2112 USD
t3.xlarge in London Linux base 0.1888 USD
t3.2xlarge in London Linux base 0.3776 USD


--- x.large comparison ---
		virginia	london
	t2/h	0,19 €	0,21 €
	t3/h	0,17 €	0,19 €
24	t2/day	4,45 €	5,07 €
24	t3/day	3,99 €	4,53 €
30	t2/month	133,6320	152,06 €
30	t3/month	119,8080	135,94 €

   t3.2x/month  240 USD a month

		11,54%	11,86%

t2 and t3 increase of 12% increase regardless of zone
---- ----- ----- -----
Performance and CPU Credits:

T2 Instances: Use a fixed CPU credit system. They accumulate CPU credits when idle and spend them when they are active. They have limited baseline CPU performance.
T3 Instances: Are more efficient with a burstable CPU model and are not only capable of sustaining burst performance but can also use unlimited mode, which allows them to exceed their CPU credits whe

In summary, T3 instances provide better overall performance, efficiency, and cost-effectiveness compared to T2 instances. For new applications and workloads, T3 is generally recommended over T2.

-->


### 2.- Download Visual Studio Code

- Go to  [https://code.visualstudio.com](https://code.visualstudio.com), download and install Visual Studio Code on your machine. 

!!! tip "Tip"
    Working on a local Visual Studio Code maximizes your productivity. You'll be able to connect to dev containers remotely or locally, install plugins, and much more.


### 3.- Dynatrace SaaS Tenant

 - You'll need a **Grail enabled Dynatrace SaaS Tenant** ([sign up here](https://dt-url.net/trial){target="_blank"}) if you don't already have one.


<div class="grid cards" markdown>
- [Let's launch and configure the remote environment:octicons-arrow-right-24:](configure.md)
</div>
