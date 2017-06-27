// Output ID of sg for all k8 related nodes
output "vpc_sg_kube_node_id" {
  value = "${aws_security_group.vpc_sg_kube_node.id}"
}

// Output ID of sg for nodes on pulic network
output "vpc_sg_kube_public_id" {
  value = "${aws_security_group.vpc_sg_kube_public.id}"
}

// Output ID of sg for nodes on private network
output "vpc_sg_kube_private_id" {
  value = "${aws_security_group.vpc_sg_kube_private.id}"
}

// Output ID of sg for all k8 related nodes
output "vpc_sg_alt_id" {
  value = "${aws_security_group.vpc_sg_alt.id}"
}

// Output ID of sg for all k8 related nodes
output "vpc_sg_admin_id" {
  value = "${aws_security_group.vpc_sg_admin.id}"
}