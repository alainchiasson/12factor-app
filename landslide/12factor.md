[12 factors apps](https://12factor.net)
=======================================
and Beyond

Principles pushed by Heroku for cloud native applications


----


[Config](https://12factor.net/config)
=====================================

The config should be seperate from the code

----


[Backing services](https://12factor.net/backing-services)
===============================================

app makes no distinction between local and third party services. Loose coupling

accessed via a URL or other locator/credentials stored in the config

Example a MySQL database is a resource; two MySQL databases are two distinct resources.

```
mysql://auth@host/db
```



----


[Build, release, run](https://12factor.net/build-release-run)
=====================================

strict separation between the build, release, and run stages

![Release](https://12factor.net/images/release.png)



----

[Build, release, run](https://12factor.net/build-release-run)
=====================================

it is impossible to make changes to the code at runtime, since there is no way to propagate those changes back to the build stage.

Every release should always have a unique release ID

Releases are an append-only ledger and any change must create a new release.



----


[Processes - share nothing](https://12factor.net/processes)
=====================================

----


[Concurrency](https://12factor.net/concurrency)
=====================================

----


[Disposability](https://12factor.net/disposability)
=====================================

----


[Logs](https://12factor.net/logs)
=====================================

----


API First
=====================================

----


measure everything
=====================================

----


authenticate and authorize
=====================================
