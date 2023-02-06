resource "aws_instance" "webserver" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "MyServer"
    Env  = "Dev"
  }
}

output "ami" {
  value = aws_instance.webserver.ami.id
}
