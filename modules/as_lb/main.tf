//auto-scaling group
resource "aws_autoscaling_group" "cbz_asg" {
  name                      = "cbz-asg"
  max_size                  = 3
  min_size                  = 1
  desired_capacity          = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
#   placement_group           = aws_placement_group.test.id
#   launch_configuration      = aws_launch_configuration.cbz_lt.name
  vpc_zone_identifier       = [	"subnet-09ee3c60a8c5c773c", "subnet-03989839a45cc5495", "subnet-037268cd09d9ddd1f"]

  launch_template {
    id      = aws_launch_template.cbz_lt.id
    version = "$Latest"
  }
}

// target groups
resource "aws_lb_target_group" "cbz_tg" {
  name     = "cbz-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0aae638ced28d13c0"
}

//load_balancer
resource "aws_lb" "cbz_lb" {
  name               = "cbz-lb"
  internal           = false
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  security_groups    = ["sg-0b60c5abb150b0f1d", "sg-09443b356a781a9c0"]
#   subnets            = [for subnet in aws_subnet.public : subnet.id]
  subnets            = ["subnet-09ee3c60a8c5c773c", "subnet-037268cd09d9ddd1f", "subnet-03989839a45cc5495"]


  enable_deletion_protection = true

  tags = {
    Environment = "production"
  }
}

//load balancer listners
resource "aws_lb_listener" "cbz_listener" {
  load_balancer_arn = aws_lb.cbz_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cbz_tg.arn
  }
}