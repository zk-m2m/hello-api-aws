This is a practical exerchise to deploy a simplified AWS infrastructure.

1. Architecture decisions and technical requirements

The service is intentionally deployed as a single-container in an AWS EC2 instance as a Docker host to mimic a real case. It also reduces the cloud costs as can be fit into a AWS Free plan.

To keep the infrastructure as simple as possible no multiple instances are deployed, no load balancers for availability and/or blue/green operations, and no CDN proxies are used. If the requirements change, the architecture must be changed.



The network infrastructure is created from scratch assuming an empty AWS account.

In a crowded account with multiple development or pull-request environments the code needs to be modified to use per-VPC networking.



There is no security to maintain save the network filtering due to the oversimplistic service to be run.

The service uses no user accounts therefore there are no identities or service accounts to maintain.

The network filtering permits port 80 only, and the API endpoint port is mapped at the container level to port 80. The service is intentionally made world-accessible, i.e. no IP-filtering is used.



The Terraform state is kept locally as this is just an exercise.

In real-life operations it mus be kept on a shared storage, for example in an AWS S3 bucket, and backed up.

2. Code modularity

The code is split to three files only:
- the Terraform setup (providers.tf)
- the AWS infrastructure setup (vpc.tf)
- the application service deployment (ec2.tf)

The name of the image to be deployed is currently hard-coded in the cloud-init config, and is burried in a base64 string as expected by AWS.

In a real-life scenario that portion should be kept in a variable, and the variable value will be generated via CI/CD scripts, or will be fed as a pipeline parameter file.

3. How to use

This example uses AWS CLI and Terraform CLI. Their installation and configuration are beyond the scope of the package.

The code assumes an AWS profile named "dev" is used and configured.

To create the infrastructure run "terraform apply".

To extract the public IP address of the API endpoint use the following command (in a *nix shell, for example bash):
        terraform show | \
        awk '(($1=="resource")&&($2=="\"aws_instance\"")&&($3=="\"ec2-docker-hello\"")) {b_filter=true} \
             $0=="" {b_filter=false} \
             ((b_filter==true)&&($1=="public_ip")) {print $3}' | \
        cut -d '"' -f2

To test the service run "curl -v http://x.x.x.x" where x.x.x.x is the IP address obtained above.

And to remove the resources so created run "terraform destroy".
