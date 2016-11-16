#/bin/bash
OUTPUT="Can't connect"

while [[ $OUTPUT == *"Can't connect"* ]]
do
  # OUTPUT=$(mysql -u root testdb < initial_sql/dbsetup.sql 2>&1)
  OUTPUT=$(mysql -h $DATABASE_HOST -u root -p$DATABASE_PASSWORD <  initial_sql/dbsetup.sql 2>&1)
  echo $OUTPUT
  sleep 1
done
