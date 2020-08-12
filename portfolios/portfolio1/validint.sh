#!/bin/bash

while [ True ]
do
    # prompt user for integer
    read -p "Enter an integer between 20 and 40: " user_int

    # check if user input is an integer AND user int is greater/equal than 20 AND less/equal than 40
    if [[ $user_int =~ ^-?[0-9]+$ ]] && [[ $user_int -ge 20 ]] && [[ $user_int -le 40 ]]; then

        # if true, inform user and exit
        echo "Valid integer ($user_int)"
        exit 0
    
    else
    # code if false
    echo "Invalid integer, try again"
    fi
done