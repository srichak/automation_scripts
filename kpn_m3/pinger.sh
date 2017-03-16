#!/bin/bash
wait_time=10
i=1
repeat=3
reached=false
while [ $i -le $repeat ] && [ $reached = false ]; do 
	echo "Ping attempt #${i}"  
	if ! ping $1 -c 3; then
		reached=false
		i=$((i+1))
		echo "Ping failed!"
		if [ $i -le $repeat ]; then
			echo "Waiting $wait_time seconds before retry"
			sleep ${wait_time}
		else
			echo "Ping failed after $((i-1)) attempts. Stopping."
		fi
	else
		reached=true
		echo "Ping succeeded!"
	fi
done
