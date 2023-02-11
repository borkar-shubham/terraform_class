resource "aws_launch_template" "cbz_lt" {
  name = "cbz_lt"
  image_id = "ami-0d32f1e246a0306ec"
  instance_type = "t2.micro"
  key_name = "cbz_key"
#   vpc_security_group_ids = ["sg-0b60c5abb150b0f1d"]
  user_data = filebase64("${path.module}/user_data.sh")

#   iam_instance_profile {
#     name = "test"
#   }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = ["sg-0b60c5abb150b0f1d"]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "as_lb_instance"
    }
  }
}

resource "aws_key_pair" "as_lb_key_pair" {
  key_name   = "cbz_key"
  public_key = file("${path.module}/id_rsa.pub")
}