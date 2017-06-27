# for each public route table, add routes to/from the vpc-mamangement
# currently all public routes share a single route table
resource "aws_route" "public_routes_to_vpcs" {
  # multiply number of public routes by number of vpc-peering-connection to include
  count                      = "${length(var.public_route_table_ids) * length(var.route_to_vpc_pcx)}"

  route_table_id             = "${element(var.public_route_table_ids, (count.index % length(var.public_route_table_ids)))}"
  destination_cidr_block     = "${element(var.route_to_vpc_cidr, (count.index % length(var.route_to_vpc_cidr)))}"
  vpc_peering_connection_id  = "${element(var.route_to_vpc_pcx, (count.index % length(var.route_to_vpc_pcx)))}"
}

# for each private route table, add routes to/from the vpc-mamangement
# each private subnet in like azs shares a route table
resource "aws_route" "private_routes_to_vpcs" {
  # multiply number of private routes by number of vpc-peering-connection to include
  count                      = "${length(var.private_route_table_ids) * length(var.route_to_vpc_pcx)}"

  route_table_id             = "${element(var.private_route_table_ids, (count.index % length(var.private_route_table_ids)))}"
  destination_cidr_block     = "${element(var.route_to_vpc_cidr, (count.index % length(var.route_to_vpc_cidr)))}"
  vpc_peering_connection_id  = "${element(var.route_to_vpc_pcx, (count.index % length(var.route_to_vpc_pcx)))}"
}
