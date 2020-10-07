#!/bin/bash

# Student Name: Kurt Barbarich
# Student Number: 10529765

while [ True ]
do
    read -p "Folder name to save your images to: " folder_name

    if [[ $folder_name =~ / ]]; then
        echo -e "Error: Do not use / in the folder name\n"
    elif [[ $folder_name =~ [[:space:]]+ ]]; then
        echo -e "Error: Do not include whitespace inside folder name\n"
    else
        echo "No spaces $folder_name"
    fi
done

while [ True ]
do
    echo -e '\nSelect an option by entering the corresponding number:\n
1) Download Single Image Thumbnail\n
2) Download Range of Image Thumbnails\n
3) Download Random Number of Image Thumbnails\n
4) Download All Image Thumbnails\n
5) Clean Up All Files\n
6) Exit Program\n'
    read -p "Selection: " option

    if [[ $option =~ ^1$ ]]; then
        continue
    elif [[ $option =~ ^2$ ]]; then
        continue
    elif [[ $option =~ ^3$ ]]; then
        continue
    elif [[ $option =~ ^4$ ]]; then
        continue
    elif [[ $option =~ ^5$ ]]; then
        continue
    elif [[ $option =~ ^6$ ]]; then
        echo 'Now exiting... Thanks for using my program!'
        break
    else
        wrong_input $option
    fi
done

exit 0