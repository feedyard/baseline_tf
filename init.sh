#!/usr/bin/env bash

echo "attempting to init with $ENVIRONMENT.tfvars"
terraform init -var-file=./$ENVIRONMENT.tfvars
terraform env select $ENVIRONMENT