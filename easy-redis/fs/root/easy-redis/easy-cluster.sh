#!/bin/bash

# CentOS7

myname=`basename $0`
mypath=$(cd `dirname $0` && pwd)

cd $mypath

usage() {
	cat <<EOF
usage: $mypath [-n ノード数(default:3)] [-r レプリカ数(default:0)]
EOF
}

opt_replica=0
opt_nodes=3
opt_port=16379
while getopts hn:r:p: c
do
    case $c in
        r)  opt_replica=$OPTARG
            ;;
        n)  opt_nodes=$OPTARG
            ;;
        p)  opt_port=$OPTARG
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


echo "### Setup config" 1>&2
$mypath/0.setup-nodes.sh -n $opt_nodes -p $opt_port
if [[  $? != 0 ]]
then
	exit 1
fi

echo "### Start nodes" 1>&2
$mypath/1.start-nodes.sh
if [[  $? != 0 ]]
then
	exit 1
fi

echo "### Make nodes cluster" 1>&2
$mypath/2.make-nodes-cluster.sh -r $opt_replica
if [[  $? != 0 ]]
then
	exit 1
fi

echo "### Waiting nodes exit" 1>&2
while true
do
	pids=`(cat node-*/*.pid) 2>/dev/null`
	if [[ -z $pids ]]
	then
		echo "Detect all nodes does not exist" 1>&2
		exit 0
	fi
	kill -0 $pids
	if [[ $? != 0 ]]
	then
		echo "Detect some node exited" 1>&2
		exit 0
	fi
	
	sleep 5
done

