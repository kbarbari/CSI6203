#!/bin/bash

# prompt user for directory name
read -p "Name of directory to be created: " dir

# make directory in working dir
mkdir $dir
echo "$dir has been created."

exit 0