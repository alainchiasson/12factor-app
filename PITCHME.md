#HSLIDE
Migrating to Kubernetes
=======================

A demonstration of taking a simple application and migrating it to Kubernetes

#HSLIDE
The app : Flask + DB
====================

This application is a simple flask application. When `/users` is called, a DB
query selects all users, which are printed out as a JSON block.

#VSLIDE

Core code
---------
``` python
@app.route("/users")
def users_index():
   to_json = lambda user...
   return json.dumps([to_json(user) for user ...)
```


#VSLIDE

Database
--------
``` SQL
INSERT INTO users VALUES (1, "admin", "admin@example.com");
INSERT INTO users VALUES (2, "guest", "guest@example.com");
```


#HSLIDE
[12 factors apps](https://12factor.net)
=======================================
and Beyond

Principles pushed by Heroku for cloud native applications

#VSLIDE

[Config](https://12factor.net/config)
=====================================

The config should be seperate from the code
#VSLIDE

[Backing services](https://12factor.net/backing-services)
===============================================

app makes no distinction between local and third party services. Loose coupling

accessed via a URL or other locator/credentials stored in the config

Example a MySQL database is a resource; two MySQL databases are two distinct resources.

```
mysql://auth@host/db
```


#VSLIDE

[Build, release, run](https://12factor.net/build-release-run)
=====================================

strict separation between the build, release, and run stages

![Release](https://12factor.net/images/release.png)


#VSLIDE
[Build, release, run](https://12factor.net/build-release-run)
=====================================

it is impossible to make changes to the code at runtime, since there is no way to propagate those changes back to the build stage.

Every release should always have a unique release ID

Releases are an append-only ledger and any change must create a new release.


#VSLIDE

[Processes - share nothing](https://12factor.net/processes)
=====================================
#VSLIDE

[Concurrency](https://12factor.net/concurrency)
=====================================
#VSLIDE

[Disposability](https://12factor.net/disposability)
=====================================
#VSLIDE

[Logs](https://12factor.net/logs)
=====================================
#VSLIDE

API First
=====================================
#VSLIDE

measure everything
=====================================
#VSLIDE

authenticate and authorize
=====================================


#HSLIDE
Running Local on the laptop
Demonstrate what is required :
Libs
Local db
Python

#HSLIDE
Moving to Docker
Building the containers
Show the docker file
Build and run the container.
Manually linking and starting
Start up the database.
Link the web service
Initialising data
Crete the new container.
Run container

#HSLIDE
Using docker compose
Bring it to a single step
Show compose file
Single use containers.
Show container.

#HSLIDE
Looking at Kubernetes (need to add networks)
The problems being solved – apps : facilitated via docker.
Move to stateless microservices
Scaling and self healing
The problems being solved – Docker
10’s of containers per service
Across multiple nodes
How to talk to each other?

#HSLIDE
Defining terms.
Quick architecture view - start at containers/pods and move up to cluster via container -> pod -> replication set / controller / deployment -> label -> service -> selector
http://kubernetes.io/docs/user-guide/
Networking - flannel and docker
External access - Ingress controller / load balancer / kube proxy

#HSLIDE
Iterating the application
Defining the database as a service
Show the YML
Loading the initial data
Show the YML
Defining the application
Show the YML
Externalizing the service
Show the YML

#HSLIDE
Work flow and talking through examples.
Developer changes code
Infrastructure improvements
Developer changes changes infrastructure
Emergency patching
