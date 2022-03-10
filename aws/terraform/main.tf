variable ssh_key_file {
  default= "~/.ssh/id_rsa.pub"
}

provider aws {
  region = "us-east-2"
  default_tags {
    tags = {
      owner = "Neil"
    }
  }
}


data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource aws_key_pair ssh01 {
  public_key = file( var.ssh_key_file )
}

resource aws_vpc vpc01 {
   cidr_block                       = "10.88.0.0/16" # Required but not used
   assign_generated_ipv6_cidr_block = true
   enable_dns_hostnames             = true
   enable_dns_support               = true
}

resource aws_internet_gateway gw01 {
  vpc_id      = aws_vpc.vpc01.id
}

resource aws_route_table rt01{
  vpc_id      = aws_vpc.vpc01.id
  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.gw01.id
  }
}

resource aws_subnet sub01 {
  vpc_id                                         = aws_vpc.vpc01.id
  assign_ipv6_address_on_creation                = true
  enable_resource_name_dns_aaaa_record_on_launch = true
  ipv6_cidr_block                                = cidrsubnet(aws_vpc.vpc01.ipv6_cidr_block, 8, 1)
  ipv6_native                                    = true
}

resource aws_route_table_association rta01 {
  subnet_id      = aws_subnet.sub01.id
  route_table_id = aws_route_table.rt01.id
}

resource aws_security_group base {
  name   = "base"
  vpc_id = aws_vpc.vpc01.id
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    ipv6_cidr_blocks = [ "::/0" ]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    ipv6_cidr_blocks = [ "::/0" ]
  }
}

resource aws_instance instance01 {
  depends_on             = [ aws_internet_gateway.gw01 ]
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.ssh01.id
  vpc_security_group_ids = [ aws_security_group.base.id ]
  subnet_id              = aws_subnet.sub01.id
  ipv6_address_count     = 1
}

output "vpc01_id" {
   value = aws_vpc.vpc01.id
}
output "ipv6_vpc_cidr_block" {
   value = aws_vpc.vpc01.ipv6_cidr_block
}
output "ipv6_subnet_cidr_block" {
  value = aws_subnet.sub01.ipv6_cidr_block
}
output "default_sg_id" {
   value = aws_vpc.vpc01.default_security_group_id
}
output "instance_fqdn" {
  value = aws_instance.instance01.public_dns
}
output "instance_ipv6_address" {
  value = aws_instance.instance01.ipv6_addresses[0]
}
output "instance_id" {
  value = aws_instance.instance01.id
}

