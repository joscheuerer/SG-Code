region = "eu-central-1"

vpc_id = "vpc-024344e8549773d40"

subnet_id = "subnet-0b77c0d76befaf70d"

security_group_ingress_rules = {
  ssh = {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }
}

security_group_egress_rules = {
  all = {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All outbound traffic"
  }
}