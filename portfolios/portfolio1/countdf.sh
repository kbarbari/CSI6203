#!/bin/bash

# find and count all files
all_files=`find $1 -maxdepth 1 -type f | wc -l`

# find and count empty files
empty_files=`find $1 -maxdepth 1 -type f -empty | wc -l`

# find all directories
all_dirs=`find $1/* -maxdepth 0 -type d | wc -l`

# find empty directories
empty_dirs=`find $1/* -maxdepth 0 -type d -empty | wc -l`

# output 
# NB: files/dirs that contain data calculated from all files/dirs minus empty files/dirs
echo -e "The $1 directory contains:
$(($all_files-$empty_files)) files that contain data
$empty_files files that are empty
$(($all_dirs-$empty_dirs)) non-empty directories
$empty_dirs empty directories"

# successful exit
exit 0






