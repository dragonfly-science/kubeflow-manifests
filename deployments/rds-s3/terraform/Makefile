SHELL := /bin/bash # Use bash syntax

TFVARS_PATH ?= sample.auto.tfvars
CLUSTER ?= $(shell cat $(TFVARS_PATH) | grep cluster_name | cut -d "=" -f2 | tr -d '"')
AWS_REGION ?= $(shell cat $(TFVARS_PATH) | grep cluster_region | cut -d "=" -f2 | tr -d '"')
CONFIG_CMD ?= aws eks update-kubeconfig --name $(CLUSTER) --region $(AWS_REGION)

deploy: init \
 create-vpc \
 create-eks-cluster \
 deploy-eks-blueprints-k8s-addons \
 deploy-kubeflow-components

delete: delete-kubeflow-components \
 delete-eks-blueprints-k8s-addons \
 delete-eks-cluster \
 delete-vpc
	terraform destroy -auto-approve

init:
	terraform init


create-vpc:
	terraform apply -target="module.vpc" -auto-approve

create-eks-cluster:
	terraform apply -target="module.eks_blueprints" -auto-approve
	terraform output -raw configure_kubectl | bash
	$(CONFIG_CMD)

deploy-eks-blueprints-k8s-addons:
	kubectl create ns nvidia-device-plugin --dry-run=client -o yaml | kubectl apply -f -
	terraform apply -target="module.eks_blueprints_kubernetes_addons" -auto-approve

deploy-kubeflow-components:
	terraform apply -target="module.kubeflow_components" -auto-approve


delete-vpc:
	terraform destroy -target="module.vpc" -auto-approve

delete-eks-cluster:
	terraform destroy -target="module.eks_blueprints" -auto-approve

delete-eks-blueprints-k8s-addons:
	terraform destroy -target="module.eks_blueprints_kubernetes_addons" -auto-approve

delete-kubeflow-components:
	terraform destroy -target="module.kubeflow_components" -auto-approve

# don't create executables
.PHONY: *