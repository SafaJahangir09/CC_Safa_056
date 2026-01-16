provider "aws" {
  region = var.region
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  owners = ["amazon"]
}

module "network" {
  source = "./modules/subnet"

  vpc_cidr_block     = var.vpc_cidr_block
  subnet_cidr_block  = var.subnet_cidr_block
  availability_zone  = var.availability_zone
  env_prefix         = var.env_prefix
}

resource "aws_security_group" "web_sg" {
  name   = "${var.env_prefix}-sg"
  vpc_id = module.network.vpc_id

  ingress {
    description = "SSH from anywhere for Lab"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # This ensures the Codespace can connect
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "key" {
  key_name   = "${var.env_prefix}-key"
  public_key = file(var.public_key_path)
}

module "frontend" {
  source = "./modules/webserver"

  ami_id             = data.aws_ami.amazon_linux.id
  instance_type      = var.instance_type
  subnet_id          = module.network.subnet_id
  security_group_ids = [aws_security_group.web_sg.id]
  key_name           = aws_key_pair.key.key_name
  name               = "${var.env_prefix}-frontend"
  count              = 1
}
module "backend" {
  source = "./modules/webserver"

  ami_id             = data.aws_ami.amazon_linux.id
  instance_type      = var.instance_type
  subnet_id          = module.network.subnet_id
  security_group_ids = [aws_security_group.web_sg.id]
  key_name           = aws_key_pair.key.key_name
  name               = "${var.env_prefix}-backend"
  count              = 3
}

resource "null_resource" "ansible_run" {
  depends_on = [
    module.frontend,
    module.backend
  ]

  provisioner "local-exec" {
    command = "cd ansible && ANSIBLE_ROLES_PATH=./roles ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory/hosts playbooks/site.yaml"
  }
}
