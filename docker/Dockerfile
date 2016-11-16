FROM ubuntu:14.04.2
MAINTAINER alainchiasson

RUN echo "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc) main universe" >> /etc/apt/sources.list
RUN apt-get update

# Add some tools
RUN apt-get install -y tar \
                       curl \
                       wget \
                       dialog \
                       net-tools \
                       build-essential\
                       python \
                       python-dev \
                       python-distribute \
                       python-pip \
                       libmysqlclient-dev

ADD /. /src
RUN pip install -r /src/requirements.txt

EXPOSE 5000
WORKDIR /src
CMD python app.py
