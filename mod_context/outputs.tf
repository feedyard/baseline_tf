output "vpc_id" {
  value = "${aws_vpc.mod.id}"
}

output "igw_id" {
  value = "${aws_internet_gateway.mod.id}"
}

output "nat_eips" {
  value = ["${aws_eip.nateip.*.id}"]
}

output "nat_eips_public_ips" {
  value = ["${aws_eip.nateip.*.public_ip}"]
}

output "natgw_ids" {
  value = ["${aws_nat_gateway.natgw.*.id}"]
}

output "public_route_table_ids" {
  value = ["${aws_route_table.public.*.id}"]
}

output "private_route_table_ids" {
  value = ["${aws_route_table.private.*.id}"]
}

output "public_kube_subnets" {
  value = ["${aws_subnet.public_kube.*.id}"]
}

output "public_alt_subnets" {
  value = ["${aws_subnet.public_alt.*.id}"]
}

output "private_kube_subnets" {
  value = ["${aws_subnet.private_kube.*.id}"]
}

output "private_alt_subnets" {
  value = ["${aws_subnet.private_alt.*.id}"]
}

output "orchestration_kube_subnets" {
  value = ["${aws_subnet.orchestration_kube.*.id}"]
}

output "orchestration_alt_subnets" {
  value = ["${aws_subnet.orchestration_alt.*.id}"]
}




//output "default_security_group_id" {
//  value = "${aws_vpc.mod.default_security_group_id}"
//}




