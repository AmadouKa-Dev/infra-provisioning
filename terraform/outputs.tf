output "public_ips" {
  description = "IP publiques des instances"
  value       = [for i in aws_instance.vm : i.public_ip]
}

/* output "inventory" {
  description = "Fichier d'inventaire Ansible généré"
  value = join("\n", [
    for idx, inst in aws_instance.vm :
    "node-${idx + 1} ansible_host=${inst.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa"
  ])
} */