#!/bin/bash

# Do not insert code above this line OR alter the code on lines 4 to 9 inclusive
declare -a hrswrk
hrswrk=(10 6 9 8 11 13 10 12 14 10 7 6 8)
prate=8
pay=0
len=${#hrswrk[*]}
i=0

# Place your code here
until [[ $i -gt 12 ]]
do
    pay=$((${hrswrk[$i]} * $prate))
    echo -n "Pay $i is $pay" && [[ $pay -gt 100 ]] && echo " [error: pay exceeds limit for this employee]" && exit 1
    echo 
    i=$(($i+1))
done

exit 0