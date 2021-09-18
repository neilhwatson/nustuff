## AWS CLI query cheatsheet

We'll use IAM policies. Query is client side filtering. That is everything is return and the results are filtered on your computer

list-policies returns a list

```
(i)neil@~ 0 $ aws iam list-policies |head
{
    "Policies": [
        {
            "PolicyName": "AWSLambdaBasicExecutionRole-9f31d9fe-6f3e-42c8-8980-cc721d8dd943",
            "PolicyId": "ANPAJFZAYMTFI5RR3GKW6",
            "Arn": "arn:aws:iam::017356389538:policy/service-role/AWSLambdaBasicExecutionRole-9f31d9fe-6f3e-42c8-8980-cc721d8dd943",
            "Path": "/service-role/",
            "DefaultVersionId": "v2",
            "AttachmentCount": 1,
            "PermissionsBoundaryUsageCount": 0,
```

We can return the first item in that list with

```
(i)neil@~ 0 $ aws iam list-policies --query='Policies[0]'
{
    "PolicyName": "AWSLambdaBasicExecutionRole-9f31d9fe-6f3e-42c8-8980-cc721d8dd943",
    "PolicyId": "ANPAJFZAYMTFI5RR3GKW6",
    "Arn": "arn:aws:iam::017356389538:policy/service-role/AWSLambdaBasicExecutionRole-9f31d9fe-6f3e-42c8-8980-cc721d8dd943",
    "Path": "/service-role/",
    "DefaultVersionId": "v2",
    "AttachmentCount": 1,
    "PermissionsBoundaryUsageCount": 0,
    "IsAttachable": true,
    "CreateDate": "2017-12-06T00:40:59+00:00",
    "UpdateDate": "2017-12-06T01:11:27+00:00"
}
```

Let's look for a policy with a known name

```
aws iam list-policies --query='Policies[?PolicyName==`test_policy`]'
[
    {
        "PolicyName": "test_policy",
        "PolicyId": "ANPAI5GYCBYQR2II4RJWG",
        "Arn": "arn:aws:iam::017356389538:policy/test_policy",
        "Path": "/",
        "DefaultVersionId": "v1",
        "AttachmentCount": 1,
        "PermissionsBoundaryUsageCount": 0,
        "IsAttachable": true,
        "CreateDate": "2017-11-25T18:57:01+00:00",
        "UpdateDate": "2017-11-25T18:57:01+00:00"
    }
]
```

Suppose we only know part of a name? Use contains

```
(i)neil@~ 0 $ aws iam list-policies --query='Policies[?contains(PolicyName, `test`)]'
[
    {
        "PolicyName": "test_policy",
        "PolicyId": "ANPAI5GYCBYQR2II4RJWG",
        "Arn": "arn:aws:iam::017356389538:policy/test_policy",
        "Path": "/",
        "DefaultVersionId": "v1",
        "AttachmentCount": 1,
        "PermissionsBoundaryUsageCount": 0,
        "IsAttachable": true,
        "CreateDate": "2017-11-25T18:57:01+00:00",
        "UpdateDate": "2017-11-25T18:57:01+00:00"
    }
]
```

Let's reduce the output to only the desired field, the policy name

```
(i)neil@~ 0 $ aws iam list-policies --query='Policies[?contains(PolicyName, `test`)].PolicyName'
[
    "test_policy"
]
```

Now the policy name and the Arn

```
(i)neil@~ 0 $ aws iam list-policies --query='Policies[?contains(PolicyName, `test`)].[PolicyName,Arn]'
[
    [
        "test_policy",
        "arn:aws:iam::017356389538:policy/test_policy"
    ]
]
```

You can format this with field names too

```
(i)neil@~ 0 $ aws iam list-policies --query='Policies[?contains(PolicyName, `test`)].{Name:PolicyName,Arn:Arn}'
[
    {
        "Name": "test_policy",
        "Arn": "arn:aws:iam::017356389538:policy/test_policy"
    }
]
```

Change the output to plain text

```
(i)neil@~ 0 $ aws iam list-policies --query='Policies[?contains(PolicyName, `test`)].[PolicyName,Arn]' --output text
test_policy     arn:aws:iam::017356389538:policy/test_policy
```

## AWS cli filters

To reduce the data returned you can use, where available, the filters option

Consider VPCs

```
(i)neil@~ 0 $ aws ec2 describe-vpcs |head -7
{
    "Vpcs": [
        {
            "CidrBlock": "10.98.0.0/16",
            "DhcpOptionsId": "dopt-5c9b4f35",
            "State": "available",
            "VpcId": "vpc-f74a6b9e",

```

How many are there?

```
(i)neil@~ 0 $ aws ec2 describe-vpcs --query='Vpcs[].[VpcId]'
[
    [
        "vpc-f74a6b9e"
    ],
    [
        "vpc-ae12d8c7"
    ]
]
```

Annoyingly filtering is a different syntax than query and only certain command and filter are available.  For VPCs https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-vpcs.html

Not a long list, but suppose it's longer? We want to filter before we get the data. We only want VPCs with a specific cidr block

```
(i)neil@~ 0 $ aws ec2 describe-vpcs --filters='Name=cidr,Values=10.98.0.0/16'|head -7
{
    "Vpcs": [
        {
            "CidrBlock": "10.98.0.0/16",
            "DhcpOptionsId": "dopt-5c9b4f35",
            "State": "available",
            "VpcId": "vpc-f74a6b9e",
```

We can combine filters and query

```
(i)neil@~ 0 $ aws ec2 describe-vpcs --filters='Name=cidr,Values=10.98.0.0/16' --query='Vpcs[].[VpcId,CidrBlock]'
[
    [
        "vpc-f74a6b9e",
        "10.98.0.0/16"
    ]
]
```


