#!bash

#Simple script scans photos and movies files, starting with IMG_ and VID_ and places them onto created directories which are named as YYYY_MM_DD (year, month and day)
#Скрипт создает в текущей директории каталоги с именем ГГГГ_ММ_ДД и помещает в них файлы, в названиях которых содержится указанная дата 

create_dirs_and_move_files() {
    files=$1
    file_mask=$2
    
    for f in $files 
	do
	    year=${f:0:4}
	    month=${f:4:2}
	    day=${f:6:2}
	    dir="${year}_${month}_${day}"
	
	    if ! [ -d $dir ]
	    then
		echo "Making directory ${dir}.."
		mkdir ${dir}
	    else
		echo "Directory ${dir} exists. Going on."
	    fi
	
	    f_mask=$file_mask
	    
	    f_mask=${f_mask/year/$year}
	    f_mask=${f_mask/month/$month}
	    f_mask=${f_mask/day/$day}
	    
	    echo "Moving file(s) ${f_mask} into directory ${dir}.."
	    mv -n ${f_mask} ${dir}
    done
    
}

create_dirs_and_move_files "$(ls IMG_*.jpg | sed -e 's/IMG_//; s/_.*$//' | uniq)" "IMG_yearmonthday_??????.jpg"
create_dirs_and_move_files "$(ls VID_*.mp4 | sed -e 's/VID_//; s/_.*$//' | uniq)" "VID_yearmonthday_??????.mp4"
