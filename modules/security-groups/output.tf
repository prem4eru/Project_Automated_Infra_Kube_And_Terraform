output "slab_ai_sg_id" {
  description = "The ID of the slab_ai security group"
  value       = aws_security_group.slab_ai_sg.id
}

output "eks_sg" {
  description  = "This is for EKS cluster "
  value = aws_security_group.eks_sg.id
}
