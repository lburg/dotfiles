load_dump () {
  SCRIPT="$1"
  USER="$2"
  DATABASE="${USER}_prod"
  TEST_DATABASE="test_$USER"
  LOGFILE=importer.log
  MISSING_TABLES=missing_tables

  echo $DATABASE
  echo $TEST_DATABASE

  list_tables () {
      psql -qAt -c "select tablename from pg_tables where schemaname = 'public';" $1
  }

  if [[ $# -ge 2 ]]
  then
      echo > $LOGFILE
      dropdb $DATABASE || true
      # if you have a template_postgis
      # createdb -T template_postgis -U $USER $DATABASE
      # else
      createdb -O $USER $DATABASE
      # only for postgis 2+ if postgis extension is not in your template1
      psql -L $LOGFILE -c "CREATE EXTENSION POSTGIS" $DATABASE
      # if you need to migrate dump for postGIS1.5 to postGIS2+
      # time postgis_restore.pl $SCRIPT | psql $DATABASE 2>&1 | tee -a $LOGFILE
      # else
      time pg_restore -O -j3 -d $DATABASE $SCRIPT 2>&1 | tee -a $LOGFILE
      for tbl in `psql -qAt -c "select tablename from pg_tables where schemaname = 'public';" $DATABASE` ; do psql -c "alter table $tbl owner to $USER" $DATABASE ; done
      echo "************************"
      echo "Restoring missing tables"
      echo "************************"
      # note missing tables generation requires a working test_<projet> database.
      grep -vxF -f <(list_tables $DATABASE) <(list_tables $TEST_DATABASE) > $MISSING_TABLES
      pg_dump $TEST_DATABASE --schema-only -Fc `exec sed 's/^/-t /' $MISSING_TABLES` > $MISSING_TABLES
      time pg_restore -O -j3 -d $DATABASE $MISSING_TABLES 2>&1 | tee -a $LOGFILE
      echo "the following commands may be needed:"
      echo '    echo -e "[db]\nname=$(DATABASE)\n" >> local_settings.ini'
      echo "    ./manage.py syncdb --migrate"
      echo "    ./manage.py set_fake_passwords --password=autolib"
  else
      echo "Usage: $0 <filename> <project>"
      echo
  fi
}

zle -N load_dump
