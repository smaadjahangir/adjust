#!/bin/bash
# Variable as Input
START=${1:-1}
END=${2:-10}

# If variable has no Input then taking default value
if [ -z "$START" ] || [ -z "$END" ]
then
      echo "Msg: Start or End number missing, taking default value for missing number"
fi

# Output to Terminal
seq $START $END | sort -R

