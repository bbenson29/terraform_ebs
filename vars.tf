variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "eu-west-1"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}
variable "user" {
  default = {
    ubuntu = "ubuntu"
    rhel6 = "ec2-user"
}
}
variable "AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-13be557e"
    eu-west-1 = "ami-844e0bf7"
  }
}
variable "subnet_id" {
  default = "subnet-f9cf78a1"
}
variable "key_name" {
  default = "mykey"
}
variable "availability_zone" {
  default = "eu-west-1b"
}
variable "DEVICE" {
  default = "/dev/xvdf"
}
