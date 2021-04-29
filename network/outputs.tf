output "vpc_id" {
    value = aws_vpc.VPC.id
    description = "The generated vpc id"
}

output "nacl_id" {
    value = aws_vpc.VPC.default_network_acl_id
    description = "The generated nacl"
}

output "route_table_id" {
    value = aws_vpc.VPC.default_route_table_id
    description = "The generated route table"
}

output "tenancy" {
    value = aws_vpc.VPC.instance_tenancy
    description = "The default tenancy"
}

output "dhcp_options_id" {
    value = aws_vpc.VPC.dhcp_options_id
    description = "The default dhcp_options_id"
}

output "default_security_group_id" {
    value = aws_vpc.VPC.default_security_group_id
    description = "The default security group id"
}

output "PublicSubnetA" {
    value = aws_subnet.PublicSubnetA.id
}

output "PublicSubnetB" {
    value = aws_subnet.PublicSubnetB.id
}

output "PublicSubnetC" {
    value = aws_subnet.PublicSubnetC.id
}

output "AppA" {
    value = aws_subnet.AppA.id
}

output "AppB" {
    value = aws_subnet.AppB.id
}

output "AppC" {
    value = aws_subnet.AppC.id
}
