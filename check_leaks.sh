#!/bin/bash

if [ $# == 0 ]; then
	NAME=minishell
else
	NAME=$1
fi

while sleep 1;
do
	PID=$(ps | grep $NAME | grep -Ev "grep|/bin/bash" | cut -c 1-5)
	ARRAY=($PID)
	clear;
	for pid in ${ARRAY[@]}
	do
		RESULT=$(leaks $pid 2>&1 | grep -E "$pid|bytes")
		RESULT_ARRAY=($RESULT)
		echo "$RESULT"
		echo $'\n'
	done
	if [[ "$PID" == "" ]]; then
		echo "$NAME is not running..."
	fi
done
