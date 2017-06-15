#!/usr/bin/env bash

terraform get
terraform plan -detailed-exitcode -var-file=./$ENVIRONMENT.tfvars -out=./$ENVIRONMENT.plan