output "bastionA_IP" {
  value = aws_instance.BastionA.public_ip
}

output "bastionB_IP" {
  value = aws_instance.BastionB.public_ip
}

output "bastionC_IP" {
  value = aws_instance.BastionC.public_ip
}

output "AppA_IP" {
  value = aws_instance.AppA.private_ip
}

output "AppB_IP" {
  value = aws_instance.AppB.private_ip
}

output "AppC_IP" {
  value = aws_instance.AppC.private_ip
}