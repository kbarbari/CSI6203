#!/bin/bash

read -p "Name of new directory:" directory

mkdir $directory

curl -s "https://www.ecu.edu.au/servicecentres/MACSC/gallery/gallery.php?folder=schools-2018-science-cyber" > temp.txt


exit 0