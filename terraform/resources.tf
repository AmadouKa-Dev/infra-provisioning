# 🔒 Security group : autorise SSH (22) et HTTP (80)
resource "aws_security_group" "web_app_sg" {
  name        = "webapp-sg"
  description = "groupe de securite pour la vm web-app"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

# Va nous servir pour le Django exposé sur le port 80
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-app-sg"
  }
}

# 🔑 Importer la clé SSH dans AWS
resource "aws_key_pair" "opentofu_key" {
  key_name   = var.key_name
  public_key = file(var.ssh_public_key_path)
}

# 🖥️ Création des instances EC2
resource "aws_instance" "vm" {
  count = var.instance_count
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = aws_key_pair.opentofu_key.key_name
  subnet_id = data.aws_subnet.default.id
  security_groups = [aws_security_group.web_app_sg.id]

  # initialisation à la création de la vm -> installe Python pour Ansible par la suite
  user_data = <<-EOF
              #cloud-config
              package_update: true
              packages:
                - python3
              EOF

  tags = {
    Name = "webapp-vm-${count.index + 1}"
  }

}