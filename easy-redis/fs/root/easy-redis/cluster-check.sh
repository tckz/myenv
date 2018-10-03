#!/bin/bash

myname=`basename $0`
mypath=$(cd `dirname $0` && pwd)

redis_trib=$mypath/redis-trib.rb

if [[ ! -x $redis_trib ]]
then
	echo "*** $redis_trib not exist or not executable" 1>&2
	exit 1
fi


myaddr=`getent ahosts $HOSTNAME | grep STREAM | awk '{print $1}'`
echo "IP-Addr: $myaddr" 1>&2

cd $mypath

echo_nodes() {
	for i in node-*
	do
		if [[ -d $i ]]
		then
			local port=`echo $i | sed -e 's/^node-//'`
			echo "$myaddr:$port"
		fi
	done
}

first_node=`echo_nodes | head -1`
if [[ -z $first_node ]]
then
	echo "*** There is no node config." 1>&2
	exit 1
fi

$redis_trib check $first_node

