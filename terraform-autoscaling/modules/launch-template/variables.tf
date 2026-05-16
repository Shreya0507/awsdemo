variable "ami_id" {
  type = string
}

variable "instance_type" {
  default = "t3.micro"
}

variable "ec2_sg_id" {
  type = string
}