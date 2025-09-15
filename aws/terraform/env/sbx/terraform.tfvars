aws_region          = "us-west-2"
environment         = "test"
instance_count      = 2
instance_type       = "t3.small"
ami_name_pattern    = "amzn2-ami-hvm-*-x86_64-gp2"
ami_owner           = "amazon"
allowed_http_cidr   = ["0.0.0.0/0"]
allowed_https_cidr  = ["0.0.0.0/0"]
allowed_ssh_cidr    = ["10.0.0.0/8"]
bucket_purpose      = "Static web assets"
bucket_content_type = "web-assets"
project_name        = "terraform-test"
name_prefix         = ""
webserver_user_data = <<-EOF
  #!/bin/bash
  yum update -y
  yum install -y httpd
  systemctl start httpd
  systemctl enable httpd
  echo "<h1>Hello from ${environment} server</h1>" > /var/www/html/index.html
  EOF
