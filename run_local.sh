#!/bin/bash
#
# Get proper environment
. local.env

# Are the expected env variables set ?



# Is python installed ?

if which python > /dev/null 2>&1;
then
    echo "Python detected"
else
    echo "Python not installed"
    exit 1
fi
# Are the proper python libs installed (there must be a better way of doing this)
req_libs=( "flask" "flask_sqlalchemy" "mysql.connector" "json" "os")

for lib in "${req_libs[@]}"
do

  if ! $( python -c "import $lib" )
  then
    echo "Library missing: $lib"
    exit 1
  fi

done

# Is mysql installed, running and can I connect to it, is the database there.
if which mysqld > /dev/null 2>&1;
then
    echo "Mysql server detected."
else
    echo "Mysql server not installed."
    exit 1
fi

if which mysql > /dev/null 2>&1;
then
    echo "Mysql Client detected."
else
    echo "Mysql Client not installed."
    exit 1
fi

# Test for connectivity to server with database.
if $( echo "exit" | mysql -u $DATABASE_USER -p$DATABASE_PASSWORD -h $DATABASE_HOST)
then
  echo "Connecting to Mysql"
else
  echo "Cannot connect to Mysql"
  exit 1
fi

# Drop and setup inital database
if $( cat initial_sql/dbsetup.sql | mysql -u $DATABASE_USER -p$DATABASE_PASSWORD )
then
  echo "Loaded inital database"
else
  echo "DBload failed"
  exit 1
fi

# Run the application

python app.py
