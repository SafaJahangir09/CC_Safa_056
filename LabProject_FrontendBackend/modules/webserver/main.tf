resource "aws_instance" "this" {
  count = var.count_no

  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  key_name               = var.key_name
  associate_public_ip_address = true
  tags = {
    Name = "${var.name}-${count.index}"
  }
}


