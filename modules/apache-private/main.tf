# Get latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Launch 2 Apache EC2 instances in private subnets
resource "aws_instance" "apache_private" {
  count                  = 2
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_ids[count.index]
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name

  user_data = templatefile("${path.module}/userdata.tpl", {
    page_content = count.index == 0 ? "Welcome to Private Page1 !" : "Welcome to Private Page2 !"
  })

  tags = {
    Name = format("%s-%d", var.instance_name_prefix, count.index + 1)
  }
}
