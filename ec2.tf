data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_key_pair" "terraform_ec2_key" {
  key_name   = "terraform_ec2_key"
  public_key = file(var.public_key_path)

  tags = {
    Name  = "terraform_ec2_key - DM"
    Owner = "DM"
  }
}

resource "aws_security_group" "sg_bastion" {
  name   = "sg_bastion"
  vpc_id = aws_vpc.VPC.id

  ingress {
    description = "allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "sg_bastion - DM"
    Owner = "DM"
  }
}

resource "aws_instance" "BastionA" {
  ami             = data.aws_ami.amazon-linux-2.id
  instance_type   = "t3.micro"
  key_name        = aws_key_pair.terraform_ec2_key.id
  security_groups = [aws_security_group.sg_bastion.id]
  subnet_id       = aws_subnet.PublicSubnetA.id

  tags = {
    Name  = "Bastion A - DM"
    Owner = "DM"
  }
}

resource "aws_instance" "BastionB" {
  ami             = data.aws_ami.amazon-linux-2.id
  instance_type   = "t3.micro"
  key_name        = aws_key_pair.terraform_ec2_key.id
  security_groups = [aws_security_group.sg_bastion.id]
  subnet_id       = aws_subnet.PublicSubnetB.id

  tags = {
    Name  = "Bastion B - DM"
    Owner = "DM"
  }
}

resource "aws_instance" "BastionC" {
  ami             = data.aws_ami.amazon-linux-2.id
  instance_type   = "t3.micro"
  key_name        = aws_key_pair.terraform_ec2_key.id
  security_groups = [aws_security_group.sg_bastion.id]
  subnet_id       = aws_subnet.PublicSubnetA.id

  tags = {
    Name  = "Bastion C - DM"
    Owner = "DM"
  }
}

resource "aws_security_group" "sg_appServers" {
  name   = "sg_appServers"
  vpc_id = aws_vpc.VPC.id

  ingress {
    description = "allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "sg_appServers - DM"
    Owner = "DM"
  }
}

resource "aws_instance" "AppA" {
  ami             = data.aws_ami.amazon-linux-2.id
  instance_type   = "t3.micro"
  key_name        = aws_key_pair.terraform_ec2_key.id
  security_groups = [aws_security_group.sg_appServers.id]
  subnet_id       = aws_subnet.AppA.id

  tags = {
    Name  = "App A - DM"
    Owner = "DM"
  }
}

resource "aws_instance" "AppB" {
  ami             = data.aws_ami.amazon-linux-2.id
  instance_type   = "t3.micro"
  key_name        = aws_key_pair.terraform_ec2_key.id
  security_groups = [aws_security_group.sg_appServers.id]
  subnet_id       = aws_subnet.AppB.id

  tags = {
    Name  = "App B - DM"
    Owner = "DM"
  }
}

resource "aws_instance" "AppC" {
  ami             = data.aws_ami.amazon-linux-2.id
  instance_type   = "t3.micro"
  key_name        = aws_key_pair.terraform_ec2_key.id
  security_groups = [aws_security_group.sg_appServers.id]
  subnet_id       = aws_subnet.AppC.id

  tags = {
    Name  = "App C - DM"
    Owner = "DM"
  }
}