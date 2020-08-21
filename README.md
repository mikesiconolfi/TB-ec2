# aws-ec2-terraform

This terraform project will deploy a new VPC with Private and Public Subnets, Nat Gateway, and all the required items to have a fully functional VPC with internet access.

This deployment has a NGINX Load balancer with 2 web servers behind it running a basic NodeJS application.

Each of the section for this dpeloyment are split up into seperate files for the type of resources that need to be deployed.

All major configurations can be applied under the `variables.tf` file within the project.

All servers deployed will be registered into AWS Route53 DNS for the hostname of the server. Make sure to modify the Zone ID to match your route53 domain.
