#!/bin/bash

# prompt user for commission 
echo -e "Please enter your commission\n(only enter an integer value):"
read num

# calculate bonus
if [ $num -le 200 ]; then
    bonus=0
elif [ $num -le 300 ]; then
    bonus=50
elif [ $num -gt 300 ]; then
    bonus=150
else
    echo "Whoops, something went wrong"
    exit 1
fi

# display applicable bonus
echo -e "Applicable bonus: \$$bonus"
exit 0


