
# EKS Control Plane Role
resource "aws_iam_role" "eks_role" {
  name = "eks-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = { Service = "eks.amazonaws.com" }
    }]
  })

  tags = {
    Name = "eks-role"
  }
}

resource "aws_iam_role_policy_attachment" "eks_policy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# EKS Cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = "my-eks-cluster"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids         = var.private_subnet_id
    security_group_ids = [var.security_group_id]
  }

  tags = {
    Name = "eks-cluster"
  }
}

# Worker Node IAM Role
resource "aws_iam_role" "worker_role" {
  name = "eks-worker-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "worker_policies" {
  count      = 2
  role       = aws_iam_role.worker_role.name
  policy_arn = element([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ], count.index)
}

resource "aws_iam_instance_profile" "worker_profile" {
  name = "eks-worker-profile"
  role = aws_iam_role.worker_role.name
}

# Worker Nodes
resource "aws_launch_template" "worker_template" {
  name_prefix          = "eks-workers"
  instance_type        = var.instance_type
  key_name             = aws_key_pair.worker.key_name
  image_id             = var.workernode_ami
  vpc_security_group_ids = [var.security_group_id]

  iam_instance_profile {
    name = aws_iam_instance_profile.worker_profile.name
  }

  tags = {
    Name = "eks-worker-template"
  }
}

resource "aws_autoscaling_group" "worker_asg" {
  desired_capacity    = 2
  max_size            = 3
  min_size            = 1
  vpc_zone_identifier = var.private_subnet_id
  launch_template {
    id      = aws_launch_template.worker_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "eks-worker"
    propagate_at_launch = true
  }
}


resource "aws_key_pair" "worker" {
  key_name   = "worker-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC3N7y+G+QPTufw7ijzwXMGwlNwX8IK2W1WIHf/8467wmVXZAb+fvAxl1RBmol1VxBLnpcLigYsJHOOIxXKUGUTnWCkA2bai6i31WvQq0lVj4IMnXRhoI1rnaoWsilibyDAkWBiWuIRmDEdRzijkkyxruWl2yJxnirJN7EXtoK420l34qt0p+Qd7oqE8sWYlllcYXYjez+CXKKOe5I5/GDDrhPztVNYD/SdQhM2M1cXJKy6opWBNwNsVT3gQve3gIFJeP6pb+RkFjX1AZjtG6bW/Zaj8R7EpbuLhVluWsnhoSNrVRESiCN3whc/E9gy8E0CqxGRMncKcZ75i3v4o+uP8KRuHZj3KfLHYiBLdZaS6YVPOBR2uF17lNu1r3CXPcXfXYfVkMIk3VvX8isfmT4WqTCR/LCsugh8+CwJudclRYjN5sh+ZS5wCT6VoOYk7ITGx9LXX1rWuaKdCT120x2Y6yWqyoRZVcE9DeP2WRuSeT7MSlJ4bKNGKdqjcKoAwyk= Manish Salona@DESKTOP-UGPC6FF"
}