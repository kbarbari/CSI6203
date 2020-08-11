#!/bin/bash

# prompt user for directory name
read -p "Name of directory to be created: " dir

# check if directory exists and inform user if true
if [ -d $dir ]; then 
    echo "That directory already exists."
    exit 1

# otherwise, make directory in working dir
else
    mkdir $dir
    echo "$dir has been created."
fi

exit 0