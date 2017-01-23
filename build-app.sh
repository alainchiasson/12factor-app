#/bin/bash

docker build -t alainchiasson/12factor:latest \
             -t alainchiasson/12factor:5.4 .

docker push alainchiasson/12factor:latest
docker push alainchiasson/12factor:5.4
