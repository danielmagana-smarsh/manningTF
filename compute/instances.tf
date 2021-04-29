resource "tls_private_key" "tls_connector" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "terraform_ec2_key" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.tls_connector.public_key_openssh

  tags = {
    Name  = "terraform_ec2_key - DM"
    Owner = "DM"
  }
}

resource "local_file" "terraform_ec2_key_file" {
    content     = tls_private_key.tls_connector.private_key_pem
    filename    = "terraform_ec2_key.pem"

    provisioner "local-exec" {
      command = "chmod 400 terraform_ec2_key.pem"
    }
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "BastionA" {
  ami             = data.aws_ami.amazon-linux-2.id
  instance_type   = "t3.micro"
  key_name        = aws_key_pair.terraform_ec2_key.id
  security_groups = [var.sg_bastion]
  subnet_id       = var.PublicSubnetA

  tags = {
    Name  = "Bastion A - DM"
    Owner = "DM"
  }
}

resource "aws_instance" "BastionB" {
  ami             = data.aws_ami.amazon-linux-2.id
  instance_type   = "t3.micro"
  key_name        = aws_key_pair.terraform_ec2_key.id
  security_groups = [var.sg_bastion]
  subnet_id       = var.PublicSubnetB

  tags = {
    Name  = "Bastion B - DM"
    Owner = "DM"
  }
}

resource "aws_instance" "BastionC" {
  ami             = data.aws_ami.amazon-linux-2.id
  instance_type   = "t3.micro"
  key_name        = aws_key_pair.terraform_ec2_key.id
  security_groups = [var.sg_bastion]
  subnet_id       = var.PublicSubnetC

  tags = {
    Name  = "Bastion C - DM"
    Owner = "DM"
  }
}

resource "aws_instance" "AppA" {
  ami             = data.aws_ami.amazon-linux-2.id
  instance_type   = "t3.micro"
  key_name        = aws_key_pair.terraform_ec2_key.id
  security_groups = [var.sg_appServers]
  subnet_id       = var.AppA

  tags = {
    Name  = "App A - DM"
    Owner = "DM"
  }
}

resource "aws_instance" "AppB" {
  ami             = data.aws_ami.amazon-linux-2.id
  instance_type   = "t3.micro"
  key_name        = aws_key_pair.terraform_ec2_key.id
  security_groups = [var.sg_appServers]
  subnet_id       = var.AppB

  tags = {
    Name  = "App B - DM"
    Owner = "DM"
  }
}

resource "aws_instance" "AppC" {
  ami             = data.aws_ami.amazon-linux-2.id
  instance_type   = "t3.micro"
  key_name        = aws_key_pair.terraform_ec2_key.id
  security_groups = [var.sg_appServers]
  subnet_id       = var.AppC

  tags = {
    Name  = "App C - DM"
    Owner = "DM"
  }
}