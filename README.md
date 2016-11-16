This is tutorial for 12 factor apps into docker files.

https://www.packtpub.com/books/content/how-to-build-12-factor-design-microservices-on-docker-part-1
https://www.packtpub.com/books/content/how-to-build-12-factor-design-microservices-on-docker-part-2

It is a simple flask app with database.

Code:
=====

The code for the application is a simple flask application that talks to a database.

Running Local:
==============

The application can run locally as a python app, connecting to a mysql database. In
this case the proper  python environment must be installed along with a local
database. That database must be loaded with initial data provided in the
`load-db.sh` script, and the `initial_sql/dbsetup.sql` script.


Running in docker
=================
(needs to be done)
build image, start db, load-db, start app.

Running in docker-compose
=========================

Running in Kubernetes
=====================




With docker compose, we can

Building the docker image:
--------------------------

We can build the docker image by runnin gthe `build-image.sh` script. This will
build the `alainchiasson\12factor` application.



Building for testing:
---------------------

As everything is now in containers, we can use tools such as docker-compose to
startup the required containers sot that we can test our setup. We can build
the docker compose environment using the `run_compose.sh` script. This script will in turn run `docker-compose up` and perform the following actions :

- Startup the mysql database container with a volume mapped to the current directory
- The mysql container will install the database engine and se tthe passwords
- The container will mount the external volume that contains the init script for the Database.
- Once up , the database will then import the init script given to
- Docker will then spin up the `alainchiasson\12factor` container with the environment variables set
- The web app will start talking to the database and be ready to server traffic.

At this point, you can test the application using a query :

```
curl http://localhost:5000/users  | jq '.'

#[
#  {
#    "email": "admin@example.com",
#    "id": 1,
#    "name": "admin"
#  },
#  {
#    "email": "guest@example.com",
#    "id": 2,
#    "name": "guest"
#  }
#]

```

Use Cases
=========

The above example, while interesting are not meant to be used inside a vacuum or just because.
We are looking at multiple use cases, within specific workflows to accelerate the development
cycle. This will also have an impact on the deployment cycle.

Use Case 1: Developer modifies code
-----------------------------------

In this case the developer is modifying the code - I expect this to be the most common
scenario. The developer will make a change to the code, do unit testing, do integration testing,
and release for operational testing.

- Variables : Code
- Invariants : container bases, final infrastructure.


Use case 2: Operations requires a patch to the base OS
------------------------------------------------------

This use case is that the operations team requires a change to the base container that is used
to build the code and the infrastructure. Following these changes, we will need to see if the
code still builds and tests properly. Also we will need to test if the infrastructure will
deploy properly.

- variables: container base
- invariables: code, final infrastructure

Use Case 3: Operations does infrastructure improvements
-------------------------------------------------------

This can be born out of either problem management or new developments in infrastructure
technology. This is where operations takes the initiative to improve items within it's span of
control.

- variables: container base,  final infrastructure
- invariables: code


Use Case 4: Developer changes require infrastructure changes
------------------------------------------------------------

Typically this will happen when there is a major refactoring of code. so this scenario will be
open ended and should be collaborative. While everything may change, everything needs to be tested.

- variables: code, final infrastructure, container base.
- invariables : nothing.
