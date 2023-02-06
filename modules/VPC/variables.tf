variable "namespace" {
  type = string
}
variable "env" {
  type = string
}
variable "cidr_block" {
  type = string
}
variable "tenancy" {
  type = string
}

variable "pub_sub_cidr" {
  type = list(string)
}
variable "pvt_sub_cidr" {
  type = list(string)
}
variable "availability_zone" {
  type = list(string)
}

variable "ingress" {
  type = any
}