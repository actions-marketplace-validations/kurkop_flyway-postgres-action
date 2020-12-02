#!/bin/bash

echo $INPUT_FLYWAY_CONF_SHA | base64 -d > /flyway/conf/flyway.conf

cp $INPUT_FLYWAY_SQL/* /flyway/sql

flyway info
bash /pre-migration.sh

# Scripts before migration
cd /flyway/
echo $INPUT_PRE_MIGRATION_BASH_SHA | base64 -d > pre_migration2.sh
bash pre_migration2.sh

# Migrate
flyway migrate
flyway info

# Scripts after migration
cd /flyway/
echo $INPUT_POST_MIGRATION_BASH_SHA | base64 -d > post_migration.sh
bash post_migration.sh
