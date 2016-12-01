
# Migrating to Kubernetes
----

# Migrating to Kubernetes


A demonstration of taking a simple application and migrating it to Kubernetes

----

# The app : Flask + DB


This application is a simple flask application. When `/users` is called, a DB
query selects all users, which are printed out as a JSON block.


----


## Core code

    !python
    @app.route("/users")
    def users_index():
       to_json = lambda user...
       return json.dumps([to_json(user) for user ...)

----

## Database

    !SQL
    INSERT INTO users VALUES (1, "admin", "admin@example.com");
    INSERT INTO users VALUES (2, "guest", "guest@example.com");

----

Running Local on the laptop
Demonstrate what is required :
Libs
Local db
Python

----

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

----

Using docker compose
Bring it to a single step
Show compose file
Single use containers.
Show container.

----

Looking at Kubernetes (need to add networks)
The problems being solved – apps : facilitated via docker.
Move to stateless microservices
Scaling and self healing
The problems being solved – Docker
10’s of containers per service
Across multiple nodes
How to talk to each other?

----

Defining terms.
Quick architecture view - start at containers/pods and move up to cluster via container -> pod -> replication set / controller / deployment -> label -> service -> selector
http://kubernetes.io/docs/user-guide/
Networking - flannel and docker
External access - Ingress controller / load balancer / kube proxy

----

Iterating the application
Defining the database as a service
Show the YML
Loading the initial data
Show the YML
Defining the application
Show the YML
Externalizing the service
Show the YML

----

Work flow and talking through examples.
Developer changes code
Infrastructure improvements
Developer changes changes infrastructure
Emergency patching
