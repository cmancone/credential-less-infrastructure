data "template_file" "startup_script" {
  template = file("${path.module}/startup.sh")

  vars = {
    admin_access_id    = var.admin_access_id
    allowed_access_ids = var.allowed_access_ids
    domain_name        = var.domain_name
    name               = var.name
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "gateway_instance" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  user_data                   = data.template_file.startup_script.rendered
  vpc_security_group_ids      = [aws_security_group.gateway.id]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = false
  iam_instance_profile        = aws_iam_instance_profile.instance_profile.name

  root_block_device {
    encrypted = true
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [ami, user_data]
  }
}
