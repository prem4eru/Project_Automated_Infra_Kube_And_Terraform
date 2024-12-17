output "instance_id" {
  description = "The instance ID of the Jenkins server"
  value       = aws_instance.jenkins_server.id
}

output "instance_public_ip" {
  description = "The public IP of the Jenkins server"
  value       = aws_instance.jenkins_server.public_ip
}

output "instance_private_ip" {
  description = "The private IP of the Jenkins server"
  value       = aws_instance.jenkins_server.private_ip
}

output "instance_subnet_id" {
  description = "The subnet ID of the Jenkins server"
  value       = aws_instance.jenkins_server.subnet_id
}
