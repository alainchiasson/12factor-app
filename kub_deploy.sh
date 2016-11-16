#!/bin/bash

# Perl one liner will replace ${ENV} with the value of the env - this is simplistic - no error validation.

# pull in the environment vars

. kubernetes.env

# Deploy substituting the environment variables. simple substitution.

perl -p -e 's/\$\{([^}]+)\}/defined $ENV{$1} ? $ENV{$1} : $&/eg' kubernetes/db.yml | kubectl create -f -
perl -p -e 's/\$\{([^}]+)\}/defined $ENV{$1} ? $ENV{$1} : $&/eg' kubernetes/dbinit.yml | kubectl create -f -
perl -p -e 's/\$\{([^}]+)\}/defined $ENV{$1} ? $ENV{$1} : $&/eg' kubernetes/app.yml | kubectl create -f -
perl -p -e 's/\$\{([^}]+)\}/defined $ENV{$1} ? $ENV{$1} : $&/eg' kubernetes/ing.yml | kubectl create -f -