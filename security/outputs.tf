output "sg_bastion" {
    value = aws_security_group.sg_bastion.id
    description = "The generated security group id"
}

output "sg_appServers" {
    value = aws_security_group.sg_appServers.id
    description = "The generated security group id"
}