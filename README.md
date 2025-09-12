Terraform AWS Web Server Infrastructure
This Terraform configuration creates a basic web server infrastructure on AWS with the following components:

Resources Created
EC2 Instances: Web servers running Amazon Linux 2 with Apache
Security Group: Firewall rules for HTTP, HTTPS, and SSH access
S3 Bucket: Storage for static assets with versioning and encryption
Random ID: For unique resource naming
File Structure
.
├── main.tf                    # Core infrastructure resources
├── versions.tf               # Terraform and provider version constraints
├── providers.tf              # Provider configurations
├── variables.tf              # Input variable definitions
├── outputs.tf                # Output value definitions
├── locals.tf                 # Local values and computed expressions
├── s3.tf                     # S3 bucket and related resources
├── terraform.tfvars.example  # Example variable values
└── README.md                 # This documentation
Prerequisites
AWS CLI configured with appropriate credentials
Terraform installed (version >= 1.0)
Appropriate AWS permissions for EC2, S3, and VPC resources
Usage
1. Initialize Terraform
bash
terraform init
2. Create variable file (optional)
bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your desired values
3. Plan the deployment
bash
terraform plan
4. Apply the configuration
bash
terraform apply
5. Access your web server
After deployment, use the output web_urls to access your web servers:

bash
terraform output web_urls
6. Clean up resources
bash
terraform destroy
Configuration Options
Variables
Variable	Description	Default	Valid Values
aws_region	AWS region for resources	us-west-2	Any valid AWS region
environment	Environment name	test	dev, test, staging, prod
instance_count	Number of EC2 instances	1	1-10
Example Customization
To deploy 3 instances in development environment:

hcl
# terraform.tfvars
aws_region = "us-east-1"
environment = "dev"
instance_count = 3
Security Considerations
SSH Access: Limited to private network ranges (10.0.0.0/8)
S3 Bucket: Public access is blocked by default
Encryption: S3 bucket has server-side encryption enabled
Versioning: S3 bucket versioning is enabled for data protection
Outputs
After successful deployment, you'll see:

Instance IDs and IP addresses
Security group ID
S3 bucket name and ARN
Direct URLs to access web servers
Troubleshooting
Cannot ping EC2 instance
The security group doesn't allow ICMP traffic (ping)
Try HTTP access instead: curl http://<public-ip>
Cannot SSH to instance
SSH access is restricted to private networks (10.x.x.x)
Modify security group rules if needed
S3 bucket name conflicts
Bucket names must be globally unique
The configuration uses random suffixes to avoid conflicts
Cost Estimation
EC2 t3.small: $0.02/hour ($15/month per instance)
S3 storage: ~$0.023/GB/month
Data transfer: First 1GB/month is free
Next Steps
Add SSL/TLS certificates for HTTPS
Implement load balancing for multiple instances
Add monitoring and logging
Configure auto-scaling groups
Implement backup strategies
