#!/bin/bash

while [ True ]
do
    read -p "Enter a 3 digit number code that begins with 5: " code
    
    if [[ $code =~ ^5[0-9]{2}$ ]]; 
    then
        echo "That code is valid"
        exit 0
    else
        echo "That code is invalid"
    fi
done

