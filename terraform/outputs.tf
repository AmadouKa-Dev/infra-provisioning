output "master_ip" {
  description = "IP de la vm master"
  value = aws_instance.master.public_ip
}