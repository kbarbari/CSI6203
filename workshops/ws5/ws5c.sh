#!/bin/bash

readarray -t array < foldernames.txt


for (( i=0; i<${#array}; i++ ));
do
    folder_name="${array[${i}]}"
    CR=$'\r'
    folder_name=${folder_name%$CR}
    [[ ${#folder_name} -le 14 ]] && echo -ne "Folder $folder_name has been created\n"
done

exit 0