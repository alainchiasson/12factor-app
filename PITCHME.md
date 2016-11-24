#HSLIDE
The app : Flask + DB

Give a short description on the flask app - show the v1 code.

#VSLIDE
```python
@app.route("/users")
def users_index():
   to_json = lambda user: {"id": user.id, "name": user.username, "email": user.email}
   return json.dumps([to_json(user) for user in User.query.all()])

```

#HSLIDE
Heroku 12 factors apps for cloud native

important ones

|------------|----------|
|[Config](https://12factor.net/config)|[Backing services](https://12factor.net/backing-services)|
|[Build, release, run](https://12factor.net/build-release-run)|[Processes - share nothing](https://12factor.net/processes)|
|[Concurrency](https://12factor.net/concurrency)|[Disposability](https://12factor.net/disposability)|
|[Logs](https://12factor.net/logs)|API First|
|Telemetry (measure everything)|authenticate and authorise|

#VSLIDE

Config(https://12factor.net/config)
===================================

The config should be seperate from the code

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
