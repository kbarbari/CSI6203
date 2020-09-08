#!/bin/bash

# Store default IFS and set active IFS to 'new line'
default_ifs=IFS
IFS=$'\n';

# Initialise array
declare -a VALUES

# read each value from values.txt and store it in array
while read -r value; do
    VALUES+=($value)
done < values.txt

# calculate the length of the array
len=${#VALUES[@]}

# setup regex values:
# numbers only
nums='^[0-9]+$'
# letters only
letters='^[a-zA-Z]+$'

# loop over each value in array
for (( i=0; i<$len; i++ ));
do
    # inform user if value is made up of all numbers
    if [[ ${VALUES[$i]} =~ $nums ]]; then
        echo "${VALUES[$i]} is comprised of numbers only"

    # inform user if value is made up of all letters
    elif [[ ${VALUES[$i]} =~ $letters ]]; then
        echo "${VALUES[$i]} is comprised of letters only"

    # otherwise, value must be made of numbers and letters
    else
        echo "${VALUES[$i]} is comprised of numbers and letters"
    fi
done

# set IFS back to default and exit successfully
IFS=default_ifs
exit 0