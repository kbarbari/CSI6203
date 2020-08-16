#!/bin/bash

# loop entire script until user quits
while [ True ]
do
    # prompt user for pattern
    read -p 'Pattern: '  pattern

    # prompt user for match type until they use valid input
    while [ True ]
    do
        echo -e '\nSelect type of match (1 or 2):\n1) Exact Word\n2) Wildcard Line' 
        read match_type

        # only accept input of 1 or 2
        if [[ $match_type =~ ^[12]{1}$ ]]; then
            break
        # otherwise, conintue loop
        else
            echo "Please enter either 1 or 2 to select a match type"
        fi
    done

    # prompt user for inverted match until they use valid input
    while [ True ]
    do
        echo -e "\nInverted match (y/n): "
        read inverted

        # if user inputs 'y' or 'Y' then set grep inverse option (-v)
        if [[ $inverted =~ ^[Yy]{1}$ ]]; then
            inv_option='-v'
            break
        # if user inputs 'n' or 'N' then don't set grep inverse option
        elif [[ $inverted =~ ^[Nn]{1}$ ]]; then
            inv_option=''
            break
        # otherwise, inform user of incorrect input and conintue prompting
        else
            echo "Please enter y for an inverted match, otherwise enter n"
        fi
    done

    # calculate number of matches and each matching line 
    # use -w if match type is Exact Word
    if [ $match_type -eq 1 ]; then
            count=`grep -ciw $inv_option -e $pattern access_log.txt`
            match=`grep -inw $inv_option -e $pattern access_log.txt`
    else
            count=`grep -ci $inv_option -e $pattern access_log.txt`
            match=`grep -in $inv_option -e $pattern access_log.txt`
    fi

    # inform user if no matches
    if [ $count -eq 0 ]; then
        echo -e "\nNo matches found\n"
    # otherwise display matches  
    else
        echo -e "\nNumber of matches: $count"
        echo -e "$match\n"
    fi

    # prompt user to continue or quit until use valid input
    while [ True ]
    do
        read -p 'Search again (y/n): ' choice
        # if user enters 'Y' or 'y', rerun the script
        if [[ $choice =~ ^[Yy]{1}$ ]]; then
            break
        # if user enters 'N' or 'n', exit script
        elif [[ $inverted =~ ^[Nn]{1}$ ]]; then
            echo "Enjoy your day!"
            exit 0
        # otherwise inform user of incorrect input and continue prompting
        else
            echo "Please enter y to search again or n to quit"
        fi
    done
done