## Miscellenaeous things

### Check whether last [Travis-ci](http://travis-ci.com) built passed or failed.

    curl -s https://api.travis-ci.org/repos/<username)/<repo>/builds \
        |jq .[0].result

Returns 0 on success.

### Get creation time of docker image from local host

    curl -s --unix-socket /run/docker.sock http://docker/images/json \
        |jq '.[] | select( .RepoTags[] == "my_tag:latest" )|.Created''
