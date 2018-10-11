#!/bin/bash

trap 'kill `cat $AIRFLOW_HOME/*.pid` && wait' TERM INT

if [[ ! -e $AIRFLOW_HOME/airflow.cfg ]]
then
	airflow initdb || exit 1
fi

/bin/rm -f $AIRFLOW_HOME/*.pid 

airflow scheduler > /dev/null &
airflow webserver > /dev/null &

wait

