
variable "aws_region" {
  description = "AWS region for this project"
  type        = string
  default     = "eu-west-1"
}

variable "project_name" {
  description = "Name used to identify project resources"
  type        = string
  default     = "tech-challenge-3-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "my_ip" {
  description = "Your public IPv4 address in CIDR notation"
  type        = string
}

variable "bucket_name" {
  description = "Globally unique name for the S3 bucket"
  type        = string
}
variable "key_name" {
  description = "Existing AWS EC2 key pair name"
  type        = string
  default     = "Secret-key"
}