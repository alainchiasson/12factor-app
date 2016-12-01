# Kubernetes

---
# Pods

  - Pods are the smallest deployable units of computing that can be created and
  managed in Kubernetes.
  - They are not limited to one and can contain as many containers as needed
  - They share a set of Linux namespaces and do not run isolated from each other.
  - They share an IP address and port space, and being able to find each other over localhost.

---

# Labels and Selectors

- key/value pairs that can be attached to objects
- used to organize and select subsets of objects
- to identify releases (beta, stable), environments (dev, prod), or tiers (frontend, backend)


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
