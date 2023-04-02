

variable "instance_type" {
  type = string
}

variable "ami_id" {
  type = string
}
variable "tag" {
  type = string

}
variable "key" {
    type = string
  
}
variable "key_name" {
  type = string
}
variable "ports" {
  type = list(number)

}
variable "SG_tag" {
  type = string

}
variable "SG_name" {
  type = string
}
variable "vpc_id" {
  type = string

}
variable "subnet_id" {
  type = string

}
