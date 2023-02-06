#VPC values
cidr_block = "10.0.0.0/16"
tenancy = "default"
namespace = "cbz"
env = "dev"

#public subnet values
pub_sub_cidr = ["10.0.0.0/18", "10.0.64.0/18"]
pvt_sub_cidr = ["10.0.128.0/18", "10.0.192.0/18"]
availability_zone = [ "	eu-north-1a", "eu-north-1b" ]