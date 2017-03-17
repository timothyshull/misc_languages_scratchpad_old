#!/usr/bin/env bash

initdb
pg_ctl -D postgres -l logfile start
createdb dbname

psql -U testuser -d people.db
