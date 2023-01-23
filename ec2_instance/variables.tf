variable "ami" {
  type = string
  default = "ami-061eda1ede961cfb2"
}

variable "instance_type" {
  type = string
  default = "t3.micro"
}

variable "security_groups" {
  type = list
  default = ["sg-03bf5ae22b55426ea"]
}