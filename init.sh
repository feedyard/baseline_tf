#!/usr/bin/env bash

terraform init -var-file=./$ENVIRONMENT.tfvars
terraform env new $ENVIRONMENT