output "bastionA_IP" {
  value = aws_instance.BastionA.public_ip
}

output "bastionB_IP" {
  value = aws_instance.BastionB.public_ip
}

output "bastionC_IP" {
  value = aws_instance.BastionC.public_ip
}