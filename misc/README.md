## Miscellaneous things

### Check whether last [Travis-ci](http://travis-ci.com) build passed or failed.

    curl -s https://api.travis-ci.org/repos/<username)/<repo>/builds \
        |jq .[0].result

Returns 0 on success.

### Get creation time of docker image from local host

    curl -s --unix-socket /run/docker.sock http://docker/images/json \
        |jq '.[] | select( .RepoTags[] == "my_tag:latest" )|.Created''
        
### More jq examples
 
    aws elb describe-load-balancers| jq -r '.LoadBalancerDescriptions[] \
        | select( .CanonicalHostedZoneName \
        | contains("awseb-e-b-AWSEBLoa") ).CanonicalHostedZoneName'
        
    aws elb describe-load-balancers | jq -r '.LoadBalancerDescriptions[] \
        | select( .CanonicalHostedZoneName \
        | test(".*\\.elb\\.") ).CanonicalHostedZoneName'

### Jq showing variable expansion and appending an array

    jq  -M --arg ami_id ${ami_id} \
        '. += [{"ParameterKey": "AMIid", "ParameterValue": $ami_id }]' \
        < inputfile > outputfile
