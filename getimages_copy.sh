#!/bin/bash

# Student Name: Kurt Barbarich
# Student Number: 10529765

resource_folder=getimages_resources
html_file=raw_html.txt
image_names=filenames.txt
has_image_folder=0
new_image_folder=0
new_resource_folder=0
declare -a files_to_delete

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

download_image() {
    declare -a downloaded_files
    declare -a non_downloaded_files
    for image in $@
    do
        if [[ -n $(find ./$folder_name -name DSC0$image.jpg) ]]; then
            echo -e "DSC0$image.jpg already exists in folder $folder_name.\n"
            while [ True ]
            do
                echo -e "Please choose what you would like to do: \n1) Skip Download \n2) Overwrite Image"
                read -p "Selection (#): " skip_or_overwrite
                clear
                if [[ $skip_or_overwrite =~ ^1$ ]]; then
                    non_downloaded_files+=($image)
                    break
                elif [[ $skip_or_overwrite =~ ^2$ ]]; then 
                    wget -q -O ./$folder_name/DSC0$image.jpg https://secure.ecu.edu.au/service-centres/MACSC/gallery/ml-2018-campus/DSC0$image.jpg               
                    downloaded_files+=($image)
                    files_to_delete+=(DSC0$image.jpg)
                    break
                else
                    echo "Invalid input; enter either 1 or 2 (#)\n"
                fi 
            done
        else
            wget -q -O ./$folder_name/DSC0$image.jpg https://secure.ecu.edu.au/service-centres/MACSC/gallery/ml-2018-campus/DSC0$image.jpg
            downloaded_files+=($image)
            files_to_delete+=(DSC0$image.jpg)
        fi
    done
    total_file_size=0
    for non_downloaded_image in ${non_downloaded_files[@]}
    do
        echo "Image DSC0$non_downloaded_image not downloaded."
    done
    for downloaded_image in ${downloaded_files[@]}
    do
        file_size=$(du -b ./$folder_name/DSC0$downloaded_image.jpg | awk '{kb=$1/1024; printf "%.2f\n", kb}')
        total_file_size=$(echo $file_size $total_file_size | awk '{sum=$1+$2; printf "%.2f\n", sum}')
        echo "Downloading DSC0$downloaded_image, with the file name DSC0$downloaded_image.jpg, with a file size of $file_size KB... File Download Complete"
    done
    if [[ ${#downloaded_files[@]} -gt 1 ]]; then
        echo "Total file size for these downloaded images is $total_file_size KB."
    fi
}

get_single_image() {
    while [ True ]
    do
        read -p "Image number you wish to download (DSC0####): " image_number
        clear
        if [[ $image_number =~ ^[0-9]{4}$ ]]; then
            if grep -xq "$image_number" ./$resource_folder/$image_names ; then
                image_number=($image_number)
                download_image "${image_number[@]}"
                break
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
            if [[ $end_number -ge $start_number ]]; then
                if grep -xq "$end_number" ./$resource_folder/$image_names ; then
                    break
                else
                    echo "Error; can't find DSC0$end_number, try another image"
                fi
            else
                echo "Invalid input; end of range must be after start of range."
            fi
        else
            echo "Invalid input; please input four numbers (####)"
        fi
    done
    clear
    start_line=$(awk -v var="$start_number" 'match($0,var){ print NR; exit }' ./$resource_folder/$image_names)
    end_line=$(awk -v var="$end_number" 'match($0,var){ print NR; exit }' ./$resource_folder/$image_names)

    images_to_download=($(awk -v start="$start_line" -v end="$end_line" 'NR>=start && NR<=end { print $1 }' ./$resource_folder/$image_names))
    echo "Processing..."
    download_image ${images_to_download[@]}
}

get_random_images() {
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
            if [[ $end_number -ge $start_number ]]; then
                if grep -xq "$end_number" ./$resource_folder/$image_names ; then
                    break
                else
                    echo "Error; can't find DSC0$end_number, try another image"
                fi
            else
                echo "Invalid input; end of range cannot be before start of range."
            fi
        else
            echo "Invalid input; please input four numbers (####)"
        fi
    done
    start_line=$(awk -v var="$start_number" 'match($0,var){ print NR; exit }' ./$resource_folder/$image_names)
    end_line=$(awk -v var="$end_number" 'match($0,var){ print NR; exit }' ./$resource_folder/$image_names)
    
    images_to_download=($(awk -v start="$start_line" -v end="$end_line" 'NR>=start && NR<=end { print $1 }' ./$resource_folder/$image_names))
    while [ True ]
    do
        read -p "Number of images between the range to download (MIN = 0, MAX = ${#images_to_download[@]}): " random_number
        if [[ $random_number =~ ^[0-9]+$ ]]; then
            if [[ $random_number -ge 0 ]] && [[ $random_number -le ${#images_to_download[@]} ]]; then
                break
            else
                echo "Invalid input; please input a number between (or equal to) the MIN and MAX values."
            fi
        else
            echo "Invalid input; please input a number."
        fi
    done

    if [[ $random_number -eq 0 ]]; then
    echo "No images to download"
        break
    else
        random_numbers=($(shuf -i $0-${#images_to_download[@]} -n $random_number))
        declare -a random_images_to_download
        for i in ${random_numbers[@]}
        do
            random_images_to_download=(${images_to_download[$i]})
        done
        echo "Processing..."
        download_image ${random_images_to_download[@]}
    fi
}

get_all_images() {
    clear
    start_line=1
    end_line=$(wc -l ./$resource_folder/$image_names | awk '{ print $1 }')

    images_to_download=($(awk -v start="$start_line" -v end="$end_line" 'NR>=start && NR<=end { print $1 }' ./$resource_folder/$image_names))
    echo "Processing..."
    download_image ${images_to_download[@]}
}

get_folders
echo -e "Preparing program...\n"

curl -s https://www.ecu.edu.au/service-centres/MACSC/gallery/gallery.php?folder=ml-2018-campus > ./$resource_folder/$html_file

cat ./$resource_folder/$html_file | grep -Eo '(https|http)://secure.ecu.edu.au/[^"]+\.jpg' | sed 's/.*\///' | sed 's/\.jpg//' | sed 's/DSC0//' > ./$resource_folder/$image_names

clear
while [ True ]
do
    echo -e '\nSelect an option by entering the corresponding number:\n
1) Download Single Image Thumbnail\n
2) Download Range of Image Thumbnails\n
3) Download Specified Number of Random Image Thumbnails\n
4) Download All Image Thumbnails\n
5) Clean Up All Files\n
6) Exit Program\n'
    read -p "Selection (#): " option

    if [[ $option =~ ^1$ ]]; then
        clear
        if [[ $has_image_folder -eq 0 ]]; then
            get_folders
        else
            get_single_image
        fi
    elif [[ $option =~ ^2$ ]]; then
        clear
        if [[ $has_image_folder -eq 0 ]]; then
            get_folders
        else
            get_range_images
        fi
    elif [[ $option =~ ^3$ ]]; then
        clear
        if [[ $has_image_folder -eq 0 ]]; then
            get_folders
        else
            get_random_images
        fi
    elif [[ $option =~ ^4$ ]]; then
        clear
        if [[ $has_image_folder -eq 0 ]]; then
            get_folders
        else
            get_all_images
        fi
    elif [[ $option =~ ^5$ ]]; then
        clear
        if [[ $new_resource_folder -eq 1 ]]; then
            rm -rf ./$resource_folder
            new_resource_folder=0
        else
            rm -f ./$resource_folder/$image_names ./$resource_folder/$html_file
        fi
        if [[ $new_image_folder -eq 1 ]]; then
            rm -rf ./$folder_name
            new_image_folder=0
        else
            for file in ${files_to_delete[@]}
            do
                rm -f ./$folder_name/$file
            done
        fi
    elif [[ $option =~ ^6$ ]]; then
        clear
        echo 'Now exiting... Thanks for using my program!'
        break
    else
        clear
        echo "Invalid input; please enter a number from 1-6 (#)"
    fi
done


exit 0