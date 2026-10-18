
output "ec2_public_ip" {
  description = "Public IP address of the web server"
  value       = aws_instance.web_server.public_ip
}

output "ec2_public_dns" {
  description = "Public DNS name of the web server"
  value       = aws_instance.web_server.public_dns
}

output "s3_bucket_name" {
  description = "Name of the project S3 bucket"
  value       = aws_s3_bucket.project_bucket.bucket
}

output "security_group_id" {
  description = "ID of the web server security group"
  value       = aws_security_group.web_sg.id
}
