#!/bin/bash

# Student Name: Kurt Barbarich
# Student Number: 10529765

resource_folder=getimages_resources
html_file=raw_html.txt
image_names=filenames.txt
has_image_folder=0
new_resource_folder=0

get_folders() {
    if [[ -d "./$resource_folder" ]]; then
        echo "Required files will be stored in $resource_folder folder"
    else
        mkdir $resource_folder
        echo "$resource_folder folder created to store required files."
        new_resource_folder=1
    fi

    while [ True ]
    do
        read -p "Folder name to save your images to: " folder_name

        if [[ $folder_name =~ / ]]; then
            echo -e "Invalid input; do not use / in the folder name\n"
        elif [[ $folder_name =~ [[:space:]]+ ]]; then
            echo -e "Invalid input; do not include whitespace inside folder name\n"
        else
            if [[ -d "./$folder_name" ]]; then
                echo "All photos will now be saved to $folder_name"
                has_image_folder=1
                break
            else
                mkdir $folder_name
                echo "Folder $folder_name created.  All photos will be saved there."  
                new_image_folder=1
                has_image_folder=1
                break
            fi
        fi
    done
}

get_single_image() {
    while [ True ]
    do
        read -p "Image number you wish to download (DSC0####): " image_number
        if [[ $image_number =~ ^[0-9]{4}$ ]]; then
            if grep -xq "$image_number" ./$resource_folder/$image_names ; then
                if [[ -n $(find ./$folder_name -name DSC0$image_number.jpg) ]]; then
                    echo -e "DSC0$image_number.jpg already exists in folder $folder_name.\n"
                    while [ True ]
                    do
                        echo -e "Please choose what you would like to do: \n1) Skip Download \n2) Overwrite Image"
                        read -p "Selection (#): " skip_or_overwrite
                        if [[ $skip_or_overwrite =~ ^1$ ]]; then
                            echo "No image downloaded, returning to main options..."
                            break 2
                        elif [[ $skip_or_overwrite =~ ^2$ ]]; then 
                            wget -q -O ./$folder_name/DSC0$image_number.jpg https://secure.ecu.edu.au/service-centres/MACSC/gallery/ml-2018-campus/DSC0$image_number.jpg
                            file_size=$(du -b ./$folder_name/DSC0$image_number.jpg | awk '{kb=$1/1024; printf "%.2f\n", kb}')
                            echo "Downloading DSC0$image_number, with the file name DSC0$image_number.jpg, with a file size of $file_size KB... .File Download Complete"
                            break 2
                        else
                            echo "Invalid input; enter either 1 or 2 (#)"
                        fi 
                    done
                else
                    wget -q -O ./$folder_name/DSC0$image_number.jpg https://secure.ecu.edu.au/service-centres/MACSC/gallery/ml-2018-campus/DSC0$image_number.jpg
                    file_size=$(du -b ./$folder_name/DSC0$image_number.jpg | awk '{kb=$1/1024; printf "%.2f\n", kb}')
                    echo "Downloading DSC0$image_number, with the file name DSC0$image_number.jpg, with a file size of $file_size KB... .File Download Complete"
                    break
                fi
            else
                echo "Error; can't find DSC0$image_number, try another image"
            fi
        else
            echo "Invalid input; please input four numbers (####)"
        fi
    done
}

get_range_images () {
    while [ True ]
    do
        while [ True ]
        do
            read -p "Image number at start of range (DSC0####): " start_number
            if [[ $start_number =~ ^[0-9]{4}$ ]]; then
                if grep -xq "$start_number" ./$resource_folder/$image_names ; then
                    break
                else
                    echo "Error; can't find DSC0$start_number, try another image"
                fi
            else
                echo "Invalid input; please input four numbers (####)"
            fi
        done
        while [ True ]
        do
            read -p "Image number at end of range (DSC0####): " end_number
            if [[ $end_number =~ ^[0-9]{4}$ ]]; then
                if grep -xq "$end_number" ./$resource_folder/$image_names ; then
                    break
                else
                    echo "Error; can't find DSC0$end_number, try another image"
                fi
            else
                echo "Invalid input; please input four numbers (####)"
            fi
        done
        start_line=$( awk -v var="$start_number" 'match($0,var){ print NR; exit }' ./$resource_folder/$image_names)
        end_line=$(awk -v var="$end_number" 'match($0,var){ print NR; exit }' ./$resource_folder/$image_names)
    done
}

get_folders

curl -s https://www.ecu.edu.au/service-centres/MACSC/gallery/gallery.php?folder=ml-2018-campus > ./$resource_folder/$html_file

cat ./$resource_folder/$html_file | grep -Eo '(https|http)://secure.ecu.edu.au/[^"]+\.jpg' | sed 's/.*\///' | sed 's/\.jpg//' | sed 's/DSC0//' > ./$resource_folder/$image_names

while [ True ]
do
    echo -e '\nSelect an option by entering the corresponding number:\n
1) Download Single Image Thumbnail\n
2) Download Range of Image Thumbnails\n
3) Download Random Number of Image Thumbnails\n
4) Download All Image Thumbnails\n
5) Clean Up All Files\n
6) Exit Program\n'
    read -p "Selection (#): " option

    if [[ $option =~ ^1$ ]]; then
        if [[ $has_image_folder -eq 0 ]]; then
            get_folders
        else
            get_single_image
        fi
    elif [[ $option =~ ^2$ ]]; then
        if [[ $has_image_folder -eq 0 ]]; then
            get_folders
        else
            get_range_images
        fi
    elif [[ $option =~ ^3$ ]]; then
        if [[ $has_image_folder -eq 0 ]]; then
            get_folders
        else
            read -p "# of random images to download (#): " random_number
            read -p "Image number at start of range (DSC0####): " random_start_number
            read -p "Image number at end of range (DSC0####): " random_end_number
        fi
    elif [[ $option =~ ^4$ ]]; then
        if [[ $has_image_folder -eq 0 ]]; then
            get_folders
        else
            continue
        fi
    elif [[ $option =~ ^5$ ]]; then
        continue
    elif [[ $option =~ ^6$ ]]; then
        echo 'Now exiting... Thanks for using my program!'
        break
    else
        continue
    fi
done


exit 0