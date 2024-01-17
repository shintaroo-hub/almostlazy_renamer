read -p "Enter file directory for renaming files($PWD):" rename_dir

if [ -z "$rename_dir" ]
then
	rename_dir=$PWD
fi

echo directory name is $rename_dir

read -p "Enter file extension to rename(mkv):" rename_ext

if [ -z "$rename_ext" ]
then rename_ext="mkv"
fi

echo extension name is $rename_ext

read -p "Enter filename template(Episode):" name_template

if [ -z "$name_template" ]
then name_template="Episode"
fi

OIFS="$IFS"
IFS=$'\n'

set full_path="${rename_dir}/*.${rename_ext}"

if [ -e $full_path]
then
	let ctrl=1
	for file_names in `ls "$rename_dir"/*."$rename_ext" | sort -V` 
	do 
		echo Enter Episode number for "$file_names":
		read episode_number

		if [ -z "$episode_number" ]
		then
			episode_number="0${ctr}"
			((ctr=$ctr+1))
		else
			episode_number="0${episode_number}"
		fi

		mv "$file_names" "${name_template}_${episode_number}.${rename_ext}"
		echo "${file_names} renamed to ${name_template}_${episode_number}.${rename_ext}"
	done

else
	read -p "No files with the extension ${rename_ext} found!" note_found
fi

read -p "Done with renaming all files! Press enter to exit" exit_prompt



