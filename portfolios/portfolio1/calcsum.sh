#!/bin/bash

# calculate sum using command arguements
sum=$(($1+$2+$3))

# write output for calculation
echo "The sum of $1 and $2 and $3 is $sum"

# exit on success
exit 0