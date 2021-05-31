# Senior Cloud Engineer Technical Exercise
### Social Security Scotland
#### Alan Butland - June 2021

## Instructions for Deployment (using a single AWS Account)

### Preparing the AWS Account

1. Have an available AWS account
2. Create a new IAM user called 'terraform-user'
    * Take a note of the users AWS Access Key ID and AWS Secret Access Key
3. Attach the 'Administrator' policy to the User via the permissions tab

### Setting up Terraform

1. Download Terraform via https://learn.hashicorp.com/tutorials/terraform/install-cli
2. Download aws cli via https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html
   * Configure aws cli by typing ```aws configure``` and entering your Access Key and Secret Access key.   Enter region as 'eu-west-2' and output as 'json'
3. Download git via https://gist.github.com/derhuerst/1b15ff4652a867391f03
4. Change to a directory of your choice and download the Terraform repo by using the following command 
   * ```git clone https://github.com/Methendor/terraform.git```
5. Change to the repo directory you have just downloaded and initialize Terraform with 
   * ```terraform init```

### Running the Terraform

1. Create the Terraform plan with 
   * ```terraform plan -var-file="vars/prd/env_vars.tfvars"```
   * This will show you which aws services and resources will be created.  If the plan was successful and you are unhappy, proceed to step 2
2. Run the following to deploy the infrastructure 
   * ```terraform apply -var-file="vars/prd/env_vars.tfvars"```
   * The process will begin.   It will then ask you if you want to proceed.   type ```yes```
3. Once the script has completed, it will output the DNS address of the Load Balancer in the format ```methendor-prd-alb-113492704.eu-west-2.elb.amazonaws.com```.  This is the address you will use to view the default website.   I have installed a new website to a new folder called website.  This will be in the format ```methendor-prd-alb-113492704.eu-west-2.elb.amazonaws.com/website/```
4. Please wait a few minutes for the instances to be created and updated and the web server to be initialized.

### Additional Notes

* To destroy your infrastructure, use the following: ```terraform destroy -var-file="vars/prd/env_vars.tfvars"```
* The website is located in ```/opt/bitnami/nginx/html/website/```
* Instance logs can be found in ```/var/log/cloud-init-output.log```
* To ssh onto an instance, log into AWS console, go to Systems Manager Service/Session Manager.  Click on an instance and click Start Session.  This will SSH you into the instance.
