# baseline_tf

deploy pipeline flow

sandbox_mgmt  >  sandbox_eph  >  sandbox  >  prod_mgmt  >  nonprod  >  prod

#### order

VPC peering connections require actual vpc_id to create
the admin security requires that the peering connection already be established in order to have cross-vpc sg references

Which reflects also the natural progression or order of events in creating this configuration.

therefore, in order to fully deploy this config

main.tf has sections at the bottom commented out. The plan should be deployed to production with subsequent prod deploys adding in addition terraform config. - as follow:


1. deploy with everything below the indicated division comments out (see main.tf for reference) to all - update vpc-id's

2. once created, add the actual vpc-id to the tfvars for file each environment as indicated

    (for the prod-mgmt.tfvars file, just repeat the same settings as in prod.tfvars)

3. Peering: deploy with the next section of main uncommented

at the moment, given the combination of perred netowrk in both the same account (in prod) and cross account between mgmt and nonprod, I am just assuming the manual acceptence of the peering request.

4. Now you can uncomment the remaining sections of main.tf and:

    deploy to sandbox-mgmt
    obtain the sg-agmin security group is and add to the tfvars files for sandbox-eph and sandbox
    deploy to sandbox-eph and sandbox

    deploy to prod-mgmt
    obtain the sg-agmin security group is and add to the tfvars files for nonprod and prod
    deploy to nonprod and prod
    
you can run the tests against an environment at any time, but by the final run through the pipeline the awspec tests should run green for each env


Certainly this entire thing would flow much more logically if orchestrated via a baseline.tf pipeline running on the baseline goCD instance.

an example terraform pipeline deployment logical workflow is one of the artifacts in the reference arch draft folder