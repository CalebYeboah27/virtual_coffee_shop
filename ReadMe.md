# Virtual Coffee Shop Chain - Terraform Configuration

This Terraform project enables the migration of a virtual coffee shop chain's operations to the cloud. The infrastructure is designed to provide scalability, high availability, and security for the coffee shop's digital services.

## Project Structure

```
.
├── main.tf                 # Main Terraform configuration file
├── variables.tf            # Variables definition
├── outputs.tf              # Outputs definition
├── providers.tf            # AWS provider configuration
├── network.tf              # VPC, subnets, and networking configuration
├── instances.tf            # EC2 instances and Auto Scaling Group configuration
├── load_balancer.tf        # Application Load Balancer configuration
└── security_group.tf       # Security group configuration
```

## Configuration Details

### Network Infrastructure

- **VPC (Virtual Private Cloud):** The project creates a VPC with public and private subnets spread across multiple Availability Zones for high availability.

- **Security Groups:** Security groups are defined to control inbound and outbound traffic to the instances.

### EC2 Instances and Auto Scaling

- **Launch Configuration:** Instances are launched using Auto Scaling Groups with a defined launch configuration. The launch configuration specifies the AMI, instance type, and other settings.

- **Auto Scaling Group:** The Auto Scaling Group ensures that the desired number of EC2 instances is maintained, and it can automatically adjust the capacity based on defined policies.

### Load Balancing

- **Application Load Balancer (ALB):** An ALB is used to distribute incoming traffic across multiple EC2 instances. It provides high availability and scales automatically.

### How to Use

1. **AWS Credentials:**
   Ensure that your AWS credentials are properly configured on your local machine. You can set them using environment variables or AWS CLI profiles.

2. **Terraform Configuration:**
   Update the `variables.tf` file with your specific configurations, such as region, AMI ID, instance type, etc.

3. **Initialize Terraform:**
   Run `terraform init` to initialize the Terraform project.

4. **Review Plan:**
   Run `terraform plan` to review the execution plan and ensure that it aligns with your expectations.

5. **Apply Changes:**
   Run `terraform apply` to apply the changes and provision the infrastructure on AWS.

6. **Monitor Resources:**
   Monitor your AWS Management Console or use AWS CLI commands to observe the created resources.

7. **Destroy Resources (Optional):**
   If needed, you can run `terraform destroy` to destroy the created resources. Be cautious, as this action is irreversible.

### Outputs

- **ALB DNS Name:** The DNS name of the Application Load Balancer is available as an output. This is the entry point for accessing the coffee shop's services.