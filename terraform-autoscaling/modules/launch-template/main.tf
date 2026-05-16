resource "aws_launch_template" "lt" {
  name_prefix   = "my-launch-template"
  image_id      = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = [var.ec2_sg_id]

  # 👇 ADD THIS BLOCK
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.ec2_sg_id]
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "Hello from Auto Scaling!" > /var/www/html/index.html
              EOF
  )
}