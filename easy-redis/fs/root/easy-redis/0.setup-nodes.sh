#!/bin/bash

myname=`basename $0`
mypath=$(cd `dirname $0` && pwd)

cd $mypath

usage() {
	cat <<EOF
usage: $mypath -p 開始ポート -n ノード数 [-s]

 -s : 非クラスタモード
EOF
}

opt_replica=0
opt_cluster=1
while getopts hp:n:s c
do
    case $c in
        s)  opt_cluster=0
            ;;
        p)  opt_port=$OPTARG
            ;;
        n)  opt_nodes=$OPTARG
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

if [[ -z $opt_port ]]
then
	usage
	echo "*** -p must be specified" 1>&2
	exit 1
fi


if [[ -z $opt_nodes ]]
then
	usage
	echo "*** -n must be specified" 1>&2
	exit 1
fi

(/bin/rm -fr $mypath/node-*) > /dev/null 2>&1

count=0
while [[ $count -lt $opt_nodes ]]
do
	port=$(($opt_port + $count))
	dir_node=$mypath/node-$port
	echo "### Setup $dir_node" 1>&2
	if [[ ! -d $dir_node ]]
	then
		mkdir -p $dir_node
	fi

	node_conf=$dir_node/redis.conf

	opt_cluster_value="yes"
	if [[ $opt_cluster = "0" ]]
	then
		opt_cluster_value="no"
	fi

	cat $mypath/redis.conf-template | sed -e "s/^port .*\$/port $port/" \
		-e "s_^pidfile .*\$_pidfile $dir_node/redis-$port.pid_" \
		-e "s/cluster-enabled .*\$/cluster-enabled $opt_cluster_value/" \
		> $node_conf
	if [[ $? != 0 ]]
	then
		echo "*** Failed to write config" 1>&2
		exit 1
	fi

	count=$((count + 1))
done


