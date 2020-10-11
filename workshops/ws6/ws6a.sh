#!/bin/bash

getsumlines() {
    awk '/\$[0-9]{2,3},[0-9]{3}|\$[0-9]{1},[0-9]{3},[0-9]{3}/{ print $0 }' attdata.txt > results.txt
}

getsumlines attdata.txt

cat results.txt

exit 0