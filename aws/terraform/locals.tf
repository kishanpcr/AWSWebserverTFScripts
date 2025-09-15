# locals.tf - Local values and computed expressions

locals {
  common_tags = {
    Environment = var.environment
    Project     = "terraform-test"
    ManagedBy   = "terraform"
    CreatedDate = formatdate("YYYY-MM-DD", timestamp())
  }
  
  # Naming convention
  name_prefix = "${var.environment}-webapp"
  
  # Common ports
  http_port  = 80
  https_port = 443
  ssh_port   = 22
}
