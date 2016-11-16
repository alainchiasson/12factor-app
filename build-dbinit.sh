#/bin/bash

docker build -t alainchiasson/12factor-dbinit:latest -f Dockerfile.dbloader .
docker push alainchiasson/12factor-dbinit:latest
