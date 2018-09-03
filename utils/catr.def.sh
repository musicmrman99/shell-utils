function catr {
	location="$1"
	if [ "$2" != '' ]; then
		files="$(find "$location" -mindepth 1 -maxdepth "$2" -type f | sort -d)"
	else
		files="$(find "$location" -mindepth 1 -type f | sort -d)"
	fi

	num_files=0

	for file in $files; do
		num_files="$(($num_files+1))"
		if (( "$num_files" > 1 )); then
			echo
		fi

		echo "--------------------------------------------------"
		suffix="${file##"$location"}"
		if [ "$(printf '%s' "$suffix" | head -c 1)" = '/' ]; then
			echo ".$suffix"
		else
            echo "./$suffix"
		fi
		echo "--------------------------------------------------"

		cat "$file"
	done
}
