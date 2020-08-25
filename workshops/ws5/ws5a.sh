#!/bin/bash

file=`cat data1.txt`

default_IFS=IFS
IFS=$'\n'

for line in $file;
do
    [[ $line =~ ^[0-9]{1,2}% ]] && echo $line 
done

IFS=default_IFS
exit 0