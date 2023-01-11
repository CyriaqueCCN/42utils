#!/usr/bin/env zsh

# Don't forget to set the IP
VM_IP="192.168.56.103"
PORT="4242"

SOURCE=`realpath $(dirname "$0")`

levels=("level0 level1 level2 level3 level4 level5 level6 level7 level8 level9 bonus0 bonus1 bonus2 bonus3")

usage_err="Usage: ./connect.sh (levelX | bonusX) [copy | paste <file>]"

# every found flag should be copied on its levelX/ folder under the filename "flag" for this to work
getpass() {
	if [ "$LVL" = "bonus0" ]; then
		sublvl="level9"
	elif [ "$LVL" = "level0" ]; then
		echo -n "level0"
        return
	else
		sub=$((${LVL:5:1} - 1))
		sublvl="${LVL:0:5}$sub"
	fi
	echo -n `cat "$SOURCE/$sublvl/flag"`
}

if [[ -z $1 || ! " ${levels[*]} " =~ " ${1} " ]]; then
	echo $usage_err
	exit 1
fi

LVL="$1"
SSHPASS=$(getpass)	

if [[ -n $2 && $2 = "copy" ]]; then
	sshpass -p $SSHPASS scp -o StrictHostKeyChecking=no -rqTP "$PORT" "$LVL@$VM_IP:/home/user/$LVL/*" .
	exit 0
fi

if [[ -n $2 && -n $3 && $2 = "paste" ]] ; then
    sshpass -p $SSHPASS scp -o StrictHostKeyChecking=no -rqTP "$PORT" "$3" "$LVL@$VM_IP:/tmp/$LVL"
    echo "Uploaded file to /tmp/$LVL"
    exit 0
fi

sshpass -p $SSHPASS scp -o StrictHostKeyChecking=no -rqP "$PORT" $SOURCE/peda $LVL@$VM_IP:/tmp 2>/dev/null
echo 'For easier debugging, type : '
echo 'alias gdb="gdb -q -x /tmp/peda/peda.py"'
sshpass -p $SSHPASS ssh -o StrictHostKeyChecking=no -qp "$PORT" "$LVL@$VM_IP"
