# rec-project-infra-repo
For a showcase project - fully automated deployment of infrastracture and application.

The project main purpose is to showcae a simple usecase for CI/CD pipelines integrating GitHub repositories and Google Cloud Platform (GCP).

![architecture diagram](https://github.com/MadHolm/rec-project-infra-repo/blob/main/Project-diagram.drawio.png?raw=true)

The architecture consists of the following elements:
- GitHub repositories - there are two repositories, one for the application development and the other for infrastracture development. This allows for both development processes to be independent from one another.
- CloudBuild Triggers - these are integrated with GitHub repositories, "listening" to changes in the main branches of each respective repository and reacting to changes. Each repository has a cloudbuild.yaml file which defines deployment process step by step.
- GKE Cluster (hello-world-app-cluster) - cluster defined using Terraform code in this repository. It is a simple cluster with Autpilot enabled and separate networking.
- VPC Network (gke-network) - VPC network used by the GKE cluster. Separate VPC networks allows for full control over cluster's connectivity with firewall rules as well as limits its exposure to external web traffic increasing secuity.

Deployed application is acccessible with the following link: https://boar.best 
