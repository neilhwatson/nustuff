# IPv6 only ec2 instances

## Caveats

* `aws ssm` connections don't work over IPv6
* You still need a route table (included) even though all address are public
* AWS resources don't appear to support IPv6. For example `yum install vim`, on an AWS Linux instance, will timeout
