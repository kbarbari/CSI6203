#!/bin/bash

# get file data
getprop() {
    # word count
    words=`wc -w ./$1 | awk '{ print $1 }'`

    # file size in K
    size=`ls -s ./$1 | awk '{ print $1 }'`

    # date modified in dd-mm-YY HH:MM:SS
    modified=`date -r $1 +'%d-%m-%Y %H:%M:%S'`

    # report word count, file size, & date modified to user
    echo "The file $1 contains $words words and is ${size}K in size and was last modified $modified"
}

# prompt user for filename and pass into file data function
read -p "Enter name of file to be checked: " file
getprop $file

# exit successfully
exit 0
