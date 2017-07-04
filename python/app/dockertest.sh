#!/bin/sh

docker build . -t app
docker run --rm --name app -t app

