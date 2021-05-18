### Example Javascript API using Express

## To test

    docker build -t test -f Dockerfile.test . && dockerr test

## To build and run

    docker build -t api .;docker run -it --rm  -p 8000:8000 api
