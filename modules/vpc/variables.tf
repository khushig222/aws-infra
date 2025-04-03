variable "vpc_cidr" {}
variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]  # Adjust for your region
}
