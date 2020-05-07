#!/bin/bash
# Variable as Input
START=$1
END=$2

# If variable has no Input
if [ -z "$START" ] || [ -z "$END" ]
then
      echo "Start or End number missing"
else
	# Output to Terminal
	seq $START $END | sort -R
fi

