variable "region" {
  description = "Region where the server will be deployed"
}

variable "subnet_id" {
  description = "Subnet ID for the server"
  # Add validation for appropriate subnet IDs
}

variable "security_group_ids" {
  description = "List of security group IDs for the server"
  # Add validation for appropriate security group IDs
}

provider "aws" {
  region = var.region
}

data "aws_db_instance_classes" "available_classes" {
  engine         = "mysql"  # Change this to your desired database engine
  engine_version = "5.7"    # Change this to your desired database engine version
}

resource "aws_instance" "db_instances" {
  count           = length(data.aws_db_instance_classes.available_classes.ids)
  ami             = data.aws_db_instance_classes.available_classes.amis[count.index]
  instance_type   = data.aws_db_instance_classes.available_classes.instance_classes[count.index]
  subnet_id       = var.subnet_id
  security_groups = var.security_group_ids

  tags = {
    Name = "DBInstance-${count.index}"
  }
}

output "db_instance_public_ips" {
  value = [aws_instance.db_instances[*].public_ip]
}
