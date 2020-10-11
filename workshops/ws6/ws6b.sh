#!/bin/bash

makemenu() {
    
}

# Do not alter any of the code below
read -p 'What file do you wish to analyse?: ' selfile

if [ -f $selfile ]; then
    makemenu $selfile # Where $selfie holds attdata2.txt
else
    echo "No such file; exiting program"
fi

exit 0