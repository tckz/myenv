#!/bin/bash

myname=`basename $0`
mypath=$(cd `dirname $0` && pwd)

cd $mypath

usage() {
	cat <<EOF
usage: $mypath
EOF
}

opt_replica=0
while getopts h c
do
    case $c in
        h)  
			usage
			exit 0
            ;;
        \?) 
			usage
			exit 1
            ;;
    esac
done

shift $((OPTIND - 1))

for i in node-*
do
	dir_node=$mypath/$i
	node_conf=$dir_node/redis.conf

	echo "### Start $dir_node" 1>&2
	(cd $dir_node && redis-server $node_conf)
	if [[ $? != 0 ]]
	then
		echo "*** Failed to start redis" 1>&2
		exit 1
	fi
done


