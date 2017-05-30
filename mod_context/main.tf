resource "aws_vpc" "mod" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"
  tags                 = "${merge(var.tags, map("Name", format("%s", var.name)))}"
}

resource "aws_internet_gateway" "mod" {
  vpc_id = "${aws_vpc.mod.id}"
  tags   = "${merge(var.tags, map("Name", format("%s-igw", var.name)))}"
}

resource "aws_eip" "nateip" {
  vpc   = true
  count = "${length(var.azs) * lookup(map(var.enable_nat_gateway, 1), "true", 0)}"
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = "${element(aws_eip.nateip.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public_alt.*.id, count.index)}"
  count         = "${length(var.azs) * lookup(map(var.enable_nat_gateway, 1), "true", 0)}"

  depends_on = ["aws_internet_gateway.mod"]
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.mod.id}"
}

resource "aws_route_table" "public" {
  vpc_id           = "${aws_vpc.mod.id}"
  propagating_vgws = ["${var.public_propagating_vgws}"]
  tags             = "${merge(var.tags, map("Name", format("%s-rt-public", var.name)))}"
}

resource "aws_route" "private_nat_gateway" {
  route_table_id         = "${element(aws_route_table.private.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.natgw.*.id, count.index)}"
  count                  = "${length(var.azs) * lookup(map(var.enable_nat_gateway, 1), "true", 0)}"
}

resource "aws_route_table" "private" {
  vpc_id           = "${aws_vpc.mod.id}"
  propagating_vgws = ["${var.private_propagating_vgws}"]
  count            = "${length(var.azs)}"
  tags             = "${merge(var.tags, map("Name", format("%s-rt-private-%s", var.name, element(var.azs, count.index))))}"
}

resource "aws_subnet" "public_kube" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${var.public_kube_subnets[count.index]}"
  availability_zone = "${element(var.azs, count.index)}"
  count             = "${length(var.public_kube_subnets)}"
  tags              = "${merge(var.tags, map("Name", format("%s-public-kube-subnet-%s", var.name, element(var.azs, count.index))))}"

  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"
}

resource "aws_route_table_association" "public_kube" {
  count          = "${length(var.public_kube_subnets)}"
  subnet_id      = "${element(aws_subnet.public_kube.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_subnet" "public_alt" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${var.public_alt_subnets[count.index]}"
  availability_zone = "${element(var.azs, count.index)}"
  count             = "${length(var.public_alt_subnets)}"
  tags              = "${merge(var.tags, map("Name", format("%s-public-alt-subnet-%s", var.name, element(var.azs, count.index))))}"

  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"
}

resource "aws_route_table_association" "public_alt" {
  count          = "${length(var.public_alt_subnets)}"
  subnet_id      = "${element(aws_subnet.public_alt.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_subnet" "private_kube" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${var.private_kube_subnets[count.index]}"
  availability_zone = "${element(var.azs, count.index)}"
  count             = "${length(var.private_kube_subnets)}"
  tags              = "${merge(var.tags, map("Name", format("%s-private-kube-subnet-%s", var.name, element(var.azs, count.index))))}"
}

resource "aws_route_table_association" "private_kube" {
  count          = "${length(var.private_kube_subnets)}"
  subnet_id      = "${element(aws_subnet.private_kube.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}

resource "aws_subnet" "private_alt" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${var.private_alt_subnets[count.index]}"
  availability_zone = "${element(var.azs, count.index)}"
  count             = "${length(var.private_alt_subnets)}"
  tags              = "${merge(var.tags, map("Name", format("%s-private-alt-subnet-%s", var.name, element(var.azs, count.index))))}"
}

resource "aws_route_table_association" "private_alt" {
  count          = "${length(var.private_alt_subnets)}"
  subnet_id      = "${element(aws_subnet.private_alt.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}


resource "aws_subnet" "orchestration_kube" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${var.orchestration_kube_subnets[count.index]}"
  availability_zone = "${element(var.azs, count.index)}"
  count             = "${length(var.orchestration_kube_subnets)}"
  tags              = "${merge(var.tags, map("Name", format("%s-orchestration-kube-subnet-%s", var.name, element(var.azs, count.index))))}"
}

resource "aws_route_table_association" "orchestration_kube" {
  count          = "${length(var.orchestration_kube_subnets)}"
  subnet_id      = "${element(aws_subnet.orchestration_kube.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}

resource "aws_subnet" "orchestration_alt" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${var.orchestration_alt_subnets[count.index]}"
  availability_zone = "${element(var.azs, count.index)}"
  count             = "${length(var.orchestration_alt_subnets)}"
  tags              = "${merge(var.tags, map("Name", format("%s-orchestration-alt-subnet-%s", var.name, element(var.azs, count.index))))}"
}

resource "aws_route_table_association" "orchestration_alt" {
  count          = "${length(var.orchestration_alt_subnets)}"
  subnet_id      = "${element(aws_subnet.orchestration_alt.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}
