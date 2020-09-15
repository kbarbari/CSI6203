#!/bin/bash

cat attacks.html | # print html document to grep
grep "<td>" | # search for table lines in html (lines with <td>)
sed -e "s/<tr><td>//g; s/<\/td><\/tr>//g; s/<\/td><td>/./g" | # remove beginning and end of html table syntax  ; seperate columns with a period (.)
awk 'BEGIN { FS="."; printf("%-16s%s\n", "Attacks", "Instances(Q3)") } { sum=($2+$3+$4); printf("%-16s%d\n", $1, sum) }' # print table to output

# exit successfully
exit 0