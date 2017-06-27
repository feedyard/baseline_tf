# first section is building management cluster security groups
resource "aws_security_group" "vpc_sg_admin" {
  name        = "${var.name}-sg-admin"
  description = "The vpc-MGMT-sg-admin sg is defined to allow defined management cluster admin traffic"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 8
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }

  tags = "${merge(var.tags, map("Name", format("%s-sg-admin", var.name)))}"
}

resource "aws_security_group" "vpc_sg_kube_node" {
  name        = "${var.name}-sg-kube-node"
  description = "Default: All kubernetes related nodes deployed in a context are included in this sg"
  vpc_id = "${var.vpc_id}"

  # weave network
  ingress {
    from_port   = 6783
    to_port     = 6783
    protocol    = "tcp"
    self        = true
  }

  ingress {
    from_port   = 6783
    to_port     = 6784
    protocol    = "udp"
    self        = true
  }

  # Kubelet API
  ingress {
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    self        = true
  }

  ingress {
    from_port   = 10255
    to_port     = 10255
    protocol    = "tcp"
    self        = true
  }

  # kubernetes API server
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    self        = true
  }

  # general egress - nodes provisioned on private subnets have no actual outbound route by default
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }


  # the default sg for cluster nodes includes access from the management-sg-admin sg
  # add rules to this section as componentes are added to management requireing access
  #
  # examples:

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = ["${var.is_management == "true" ? format("%s", aws_security_group.vpc_sg_admin.id) : var.admin_sg}"]
  }

  tags = "${merge(var.tags, map("Name", format("%s-sg-kube-node", var.name)))}"
}

resource "aws_security_group" "vpc_sg_kube_public" {
  name        = "${var.name}-sg-kube-public"
  description  = "instances deployed in the public kube subnets support request from all sources, via lb"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(var.tags, map("Name", format("%s-sg-kube-public", var.name)))}"
}

resource "aws_security_group" "vpc_sg_kube_private" {
  name        = "${var.name}-sg-kube-private"
  description  = "instances deployed in the private kube subnets to support request from within the cluster"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    security_groups = ["${aws_security_group.vpc_sg_kube_node.id}","${var.admin_sg}"]
    self        = true
  }

  tags = "${merge(var.tags, map("Name", format("%s-sg-kube-private", var.name)))}"
}

resource "aws_security_group" "vpc_sg_alt" {
  name        = "${var.name}-sg-alt"
  description  = "persistent data targets deployed to alt subnets"
  vpc_id = "${var.vpc_id}"

  // allow FNS traffic to efs mount
  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    security_groups = ["${aws_security_group.vpc_sg_kube_private.id}"]
  }

  tags = "${merge(var.tags, map("Name", format("%s-sg-alt", var.name)))}"
}
