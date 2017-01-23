#/bin/bash

docker build \
      -t alainchiasson/12factor-dbinit:latest \
      -t alainchiasson/12factor-dbinit:5.4 \
      -f Dockerfile.dbloader .

docker push alainchiasson/12factor-dbinit:latest
docker push alainchiasson/12factor-dbinit:5.4
