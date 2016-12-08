# Intro to Kubernetes at Guavus

---

# Caveats

- This is still a work in progress
- Some things will change

We are Ok with that

---

# Outline

- Industry trends and new Tech
- 12 factor apps and Beyond - Cloud Native
- Dockers and Kubernetes
- Walk through
- Application to migrate
- Moving to Docker
- Moving to Kubernetes


---

# Industry Trends

- Agile / Velocity vs Waterfall/ Big Up Front Design
- CI / CD pipelines vs "upgrades"
- Micro-services vs SOA / Monolith
- Vertical teams vs Horizontal teams
- DevOps vs Departments

---

# Tech helping out
- API's all the way down
- Unreliable but available
- Cattle vs Pets
- Auto-healing vs Trouble shooting
- Virtualization, containers
- Cloud and GIFEE
- 12 factors and beyond

---

# [12 factors apps](https://12factor.net)

---

# 12 factor applications
Principles pushed by Heroku for cloud native applications

1. Codebase :One codebase tracked in revision control, many deploys
2. Dependencies :Explicitly declare and isolate dependencies
3. Config :Store config in the environment
4. Backing services :Treat backing services as attached resources
5. Build, release, run :Strictly separate build and run stages
6. Processes :Execute the app as one or more stateless processes

---

# 12 factor applications

7. Port binding :Export services via port binding
8. Concurrency :Scale out via the process model
9. Disposability :Maximize robustness with fast startup and graceful shutdown
10. Dev/prod parity :Keep development, staging, and production as similar as possible
11. Logs :Treat logs as event streams
12. Admin processes :Run admin/management tasks as one-off processes

---

# Highlights

# [Config](https://12factor.net/config)
The config should be seperate from the code
# [Backing services](https://12factor.net/backing-services)
app makes no distinction between local and third party services. Loose coupling

accessed via a URL or other locator/credentials stored in the config

Example a MySQL database is a resource; two MySQL databases are two distinct resources.

```
mysql://auth@host/db
```

---

# Highlights

# [Build, release, run](https://12factor.net/build-release-run)

strict separation between the build, release, and run stages

![Release](https://12factor.net/images/release.png)

It is impossible to make changes to the code at runtime, since there is no way to propagate those changes back to the build stage.

Every release should always have a unique release ID

Releases are an append-only ledger and any change must create a new release.

----

# Highlights

# [Processes - share nothing](https://12factor.net/processes)
Any data that needs to persist must be stored in a stateful backing service, typically a database. No Sticky sessions.
# [Concurrency](https://12factor.net/concurrency)
Scale out via the process model.
# [Disposability](https://12factor.net/disposability)
Maximize robustness with fast startup and graceful shutdown.
# [Logs](https://12factor.net/logs)
Logs should be treated as event streams, that is, logs are a sequence
of events emitted from an application in time-ordered sequence

---

# Beyond 12 factors

New things in building Cloud Native

# API First
designing your API first, you are able to facilitate discussion with your stakeholders
# Measure everything
Think of pushing applications to the cloud as launching a scientific instrument into space. You need to know what is going on at a distance.
# Authenticate and authorize
Security should never be an afterthought.


[Reference - Beyond the 12 factors ](https://www.cdta.org/sites/default/files/awards/beyond_the_12-factor_app_pivotal.pdf)

---

# Dockers and Kubernetes

---

# Docker and containers

- isolated process
- includes resources
- lighter than virtualization
- Black Box with operational controls
- API bassed

---

# Kubernetes and infrastructure

- Manages and organizes containers
- Opinionated
- Watches and manages them
- Across machines and infrastructure
- API driven

---

# Application

---

# Migration from app to Kubernetes

- VERY simple Flask app
- Mysql Backed database
- run_local

Standalone Deployment

# Presenter notes

1. Present application (app.py/requirements.txt)
2. Present database (dbsetup.sql)
3. Present how to scale up

---

# Migration from app to Kubernetes

1. Everything to a container
2. Seperate containers for all processes
3. Services in kubernetes, managed as deployments

# Presenter notes

Draw on the board. point out issues.

---

# Docker

- Dockerfile to build app
- Dockerfile to build dbinit
- Docker hub for Mysql
- run_docker

# Presenter notes

Talk about Build pipelines.

---

# Docker compose

- Docker compse file
- run_compse
- compose.env

# Presenter notes

---

# Kubernetes

---

# Kubernetes

- Still dealing with containers but in the cloud.
- Pods : Space where containers run
- Service : Interface to Pods
- Deployments : A pod life cycle manager
- ConfigMaps : A place to store configurations

---

# Pods

Pods are the smallest deployable units of computing that can be created and
managed in Kubernetes. More than one container can exist in a pod.

# Containers inside pods
- Share a set of Linux namespaces
- Do not run isolated from each other.
- Can share persistant and non-persistant volumes.
- Share IP address and port space and are able to find each other over localhost.

# Pods and networking
- There is no NAT between pods
- Your own IP is what others see

---

# Labels and Selectors

- key/value pairs that can be attached to objects
- used to organize and select subsets of objects
- to identify releases (beta, stable), environments (dev, prod), or tiers (frontend, backend)
- Used to manage "things" - pods, deployments, services, ports
- Used to link "things" together. Service "selects" Pods based on labels.

---

# Quick Recap

Our containers:

- 12factor
- 12factor-dbinit

Community containers:

- Mysql

---

# Mysql Community image

From [Docker hub image](https://hub.docker.com/_/mysql/)

- latest 5.7/Dockerfile
- Currently no specific configs

Environment variables used to configure:

- MYSQL_ROOT_PASSWORD
- MYSQL_DATABASE

Default

- Exports port 3306

---

# 12factor-dbinit Docker file

    !docker
    FROM mysql:latest

    COPY . .

    ENTRYPOINT [ "bash", "load-db.sh"]

Config required in ENV:

    - DATABASE_HOST
    - DATABASE_USER
    - DATABASE_PASSWORD
    - DATABASE_NAME

# Presenter notes

Steps performed :

1. Installs all required packages
2. Copies current directory (application) to current directory
3. When run - start the load-db.sh script.

---


# 12factor Docker file

    !docker
    ADD /. /src
    RUN pip install -r /src/requirements.txt

    EXPOSE 5000
    WORKDIR /src
    CMD python app.py

Config required in ENV:

    - DATABASE_HOST
    - DATABASE_USER
    - DATABASE_PASSWORD
    - DATABASE_NAME


# Presenter notes

Steps performed :

1. Installs all required packages
2. Copies current directory (application) to /src
3. Runs python app.py from /src directory
4. Tell Docker engine that port 5000 will most likley be users_index


---

# In Kubernetes

What will be needed to mimic:

  - Database server from Mysql image
  - Application from 12factor image
  - Initial DB loading from 12factor-dbinit image

But before all of this :

  - A place to store configurations

---

# ConfigMaps


    !yaml
    kind: ConfigMap
    apiVersion: v1
    metadata:
      name: db-config
    data:
      database.host: mysql
      database.user: root
      database.password: mytest
      database.name: 12factor

See :

[ConfigMap](http://kubernetes.io/docs/api-reference/v1/definitions/#_v1_configmap)

[Using ConfigMap](http://kubernetes.io/docs/user-guide/configmap/)


---

# Define : Mysql Service

    !yaml
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: mysql
      labels:
        service: mysql
        environ: dev
        version: 1
    spec:
      ports:
      - port: 3306
      selector:
        provider: mysql
        environ: dev

The service will be called "mysql" - kubernetes sets an internal DNS name

Will route traffic to *pods* with label keys and values matching this selector

In this case - all PODS with labels "provider:mysql, environ:dev"

---

# Define : Mysql Deployment

First part - definition

    !yaml
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: mysql
      labels:
        provider: mysql
        environ: dev

This is the high level part that defines a deployment.

The deployment manages the method of transition between operating states.


Additional info at [Deployment API definition](http://kubernetes.io/docs/api-reference/extensions/v1beta1/definitions/#_v1beta1_deployment)

---

# Define : Mysql Deployment - 2

Second part - spec replica set

    !yaml
    replicas: 1
    template:
      metadata:
        labels:
          provider: mysql
          environ: dev
          test: replication

Labels get associated to replica set AND the pods.

Additional info at : [Pod Template Spec](http://kubernetes.io/docs/api-reference/extensions/v1beta1/definitions/#_v1_podtemplatespec)

---

# Define : Mysql Deployment - 3

Third part - the pods and containers

    !yaml
    containers:
    - name: mysql
      image: mysql
      env:
      - name: MYSQL_ROOT_PASSWORD
        valueFrom:
          configMapKeyRef:
            name: db-config
            key: database.password
      - name: MYSQL_DATABASE
        valueFrom:
          configMapKeyRef:
            name: db-config
            key: database.name
      ports:
      - containerPort: 3306

---

# ConfigMap - Container links

Keeping environment seperate from implementation

    !yaml
    env:
    - name: MYSQL_ROOT_PASSWORD
      valueFrom:
        configMapKeyRef:
          name: db-config
          key: database.password

Comes from

    !yaml
    kind: ConfigMap
    apiVersion: v1
    metadata:
      name: db-config
    data:
      ...
      database.password: mytest
      ...

---
