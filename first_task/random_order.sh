#!/bin/bash
# Variable as Input
START_INPUT=$1
END_INPUT=$2
START=${START_INPUT:-1}
END=${END_INPUT:-10}

# If variable has no Input then taking default value
if [ -z "$START_INPUT" ] || [ -z "$END_INPUT" ]
then
      echo "Start or End number missing, taking default value for missing number"
fi

# Output to Terminal
seq $START $END | sort -R

