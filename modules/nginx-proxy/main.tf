# Use the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "nginx_proxy" {
  count                       = 2
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_ids[count.index]
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = true

  tags = {
    Name = format("%s-%d", var.instance_name_prefix, count.index + 1)
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras enable nginx1",
      "sudo yum install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

  provisioner "local-exec" {
    command = "echo public-ip${count.index + 1} ${self.public_ip} >> all-ips.txt"
  }
}
