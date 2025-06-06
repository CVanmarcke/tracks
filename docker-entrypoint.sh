#!/bin/bash

export RAILS_ENV=${RAILS_ENV:-production}
export DATABASE_NAME=${DATABASE_NAME:-tracks}
export DATABASE_HOST=${DATABASE_HOST:-db}
export DATABASE_PORT=${DATABASE_PORT:-3306}
export DATABASE_USERNAME=${DATABASE_USERNAME:-tracks}
if [ "$DATABASE_PASSWORD_EMPTY" != 1 ];
then
  export DATABASE_PASSWORD=${DATABASE_PASSWORD:-password}
else
  export DATABASE_PASSWORD=""
fi
export DATABASE_TYPE=${DATABASE_TYPE:-mysql2}
export DATABASE_ENCODING=${DATABASE_ENCODING:-utf8}

export RAILS_SERVE_STATIC_FILES=TRUE
export RAILS_LOG_TO_STDOUT=TRUE

if ! [ -f /app/database/database.sqlite3 ]; then
    echo "Database does not exist, initializing."
    mkdir /app/database
    bundle exec rake db:migrate RAILS_ENV=production
fi

exec "$@"
