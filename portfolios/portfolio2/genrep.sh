#!/bin/bash

# print html document to grep
# search for table lines in html
# remove beginning and end of html table syntax  ; seperate columns with a period (.)
# print table to output
cat attacks.html | grep "<td>" | sed -e "s/<tr><td>//g; s/<\/td><\/tr>//g; s/<\/td><td>/./g" | awk 'BEGIN { FS="."; printf("%-16s%s\n", "Attacks", "Instances") } { sum=($2+$3+$4); printf("%-16s%d\n", $1, sum) }'

# exit successfully
exit 0