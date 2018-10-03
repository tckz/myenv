#!/bin/bash

myname=`basename $0`
mypath=$(cd `dirname $0` && pwd)

cd $mypath

usage() {
	cat <<EOF
usage: $mypath
EOF
}

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

cd $mypath

myaddr=`getent ahosts $HOSTNAME | grep STREAM | awk '{print $1}'`
echo "IP-Addr: $myaddr" 1>&2

for i in node-*
do
	port=`echo $i | sed -e 's/^.*-//'`
	echo "### Shutdown node: $port" 1>&2
	redis-cli -h $myaddr -p $port shutdown
done

