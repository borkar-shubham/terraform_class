resource "aws_launch_template" "cbz_lt" {
  name = "cbz_lt"
  image_id = "ami-0d32f1e246a0306ec"
  instance_type = "t2.micro"
  key_name = "as_lb_key_pair"
  vpc_security_group_ids = ["sg-0b60c5abb150b0f1d"]
  user_data = filebase64("${path.module}/example.sh")

#   iam_instance_profile {
#     name = "test"
#   }

  network_interfaces {
    associate_public_ip_address = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "as_lb_instance"
    }
  }
}

resource "aws_key_pair" "as_lb_key_pair" {
  key_name   = var.key_pair_name
  public_key = file("${path.module}/id_rsa.pub")
}