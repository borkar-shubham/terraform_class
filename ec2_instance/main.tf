resource "aws_instance" "webserver" {
  ami           = var.ami
  instance_type = var.instance_type
  security_groups = var.security_groups

  tags = {
    Name = "MyServer"
    Env = "Dev"
  }
}
