# IPv6 only ec2 instances

## Update

Might work better now base on this new [blog entry](https://aws.amazon.com/blogs/networking-and-content-delivery/introducing-ipv6-only-subnets-and-ec2-instances/).

## Caveats

* `aws ssm` connections don't work over IPv6
* You still need a route table (included) even though all address are public
* AWS resources don't appear to support IPv6. For example `yum install vim`, on an AWS Linux instance, will timeout
