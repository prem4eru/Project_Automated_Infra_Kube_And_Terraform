resource "aws_instance" "jenkins_server" {
  ami                    = var.jenkins_server_ami
  instance_type          = var.instance_type
  key_name =   aws_key_pair.deployer.key_name
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.security_group_id]

  tags = {
    Name = "Jenkins-Server"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC3N7y+G+QPTufw7ijzwXMGwlNwX8IK2W1WIHf/8467wmVXZAb+fvAxl1RBmol1VxBLnpcLigYsJHOOIxXKUGUTnWCkA2bai6i31WvQq0lVj4IMnXRhoI1rnaoWsilibyDAkWBiWuIRmDEdRzijkkyxruWl2yJxnirJN7EXtoK420l34qt0p+Qd7oqE8sWYlllcYXYjez+CXKKOe5I5/GDDrhPztVNYD/SdQhM2M1cXJKy6opWBNwNsVT3gQve3gIFJeP6pb+RkFjX1AZjtG6bW/Zaj8R7EpbuLhVluWsnhoSNrVRESiCN3whc/E9gy8E0CqxGRMncKcZ75i3v4o+uP8KRuHZj3KfLHYiBLdZaS6YVPOBR2uF17lNu1r3CXPcXfXYfVkMIk3VvX8isfmT4WqTCR/LCsugh8+CwJudclRYjN5sh+ZS5wCT6VoOYk7ITGx9LXX1rWuaKdCT120x2Y6yWqyoRZVcE9DeP2WRuSeT7MSlJ4bKNGKdqjcKoAwyk= Manish Salona@DESKTOP-UGPC6FF"
}