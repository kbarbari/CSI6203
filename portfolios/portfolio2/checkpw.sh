#!/bin/bash

# awk begins processing after first line
# checks if password contains atleast 8 characters, 1 or more numbers, and 1 or more uppercase letters
# and informs user if password meets criteria or not
awk 'NR > 1 { 
    if ($2 ~ /.{8,}/ && $2 ~ /[0-9]+/ && $2 ~ /[A-Z]+/)
        print $2, "- meets password strength requirements"
    else
        print $2, "- does NOT meet password strength requirements"
    }' usrpwords.txt

# successfully exit
exit 0