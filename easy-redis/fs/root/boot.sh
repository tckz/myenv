#!/bin/bash

function usage()
{
	cat <<EOF 1>&2
example)
docker run --net host -ti easy-redis cluster [options]
  -n ノード数(default:3)
  -r レプリカ数(default:0)
  -p port(default:16397)
docker run --net host -ti easy-redis single [options]
  -p port(default:16397)
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

type=$1

if [[ $type = "single" ]]
then
	shift 1
	exec /root/easy-redis/easy-single.sh "$@"
elif [[ $type = "cluster" ]]
then
	shift 1
	exec /root/easy-redis/easy-cluster.sh "$@"
elif [[ $type = "help" ]] || [[ $# = 0 ]]
then
	usage
	exit 0
fi

exec "$@"


