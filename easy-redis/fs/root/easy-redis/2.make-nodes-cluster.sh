#!/bin/bash

# CentOS7

myname=`basename $0`
mypath=$(cd `dirname $0` && pwd)

# シンボリックリンクで同じディレクトリに置いてある
redis_trib=$mypath/redis-trib.rb

if [[ ! -x $redis_trib ]]
then
	echo "*** $redis_trib not exist or not executable" 1>&2
	exit 1
fi


cd $mypath

usage() {
	cat <<EOF
usage: $mypath [-r レプリカ数]
EOF
}

opt_replica=0
while getopts hr: c
do
    case $c in
        r)  opt_replica=$OPTARG
            ;;
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

myaddr=`getent ahosts $HOSTNAME | grep STREAM | awk '{print $1}'`
echo "IP-Addr: $myaddr" 1>&2

echo_nodes() {
	for i in node-*
	do
		local port=`echo $i | sed -e 's/^node-//'`
		echo "$myaddr:$port"
	done
}

# cluster化
arg_replica=""
if [[ $opt_replica -gt 0 ]]
then
	arg_replicas="--replicas $opt_replica"
fi

yes yes | $redis_trib create $arg_replicas `echo_nodes`

