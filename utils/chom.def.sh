# CHange Ownership and Mode ... of a file at the same time
function chom {
	OPT_H=0
	OPT_R=0

	while [[ "$1" == -* ]]; do
		if [ "$1" == "-h" ]; then OPT_H=1
		elif [ "$1" == "-r" ]; then OPT_R=1
		else echo "unknown option '$1', ignoring..."; fi
		shift
	done

	if [ "$OPT_H" == 1 ]; then
		echo "chom: a function that changes both ownership and permitions of 1 or more files or directories at the same time."
		echo "note: for root permitions use 'rchom' (requires sudo password)"
		echo "Syntax:   chom [-h] [-r] (username) (mode) (file|directory) [file|directory]..."
		echo "'-r' (recursive) is optional, the rest are required"
		return
	fi

	CHOWNER=$1
	CHMODE=$2

	shift
	shift

	while [ "$1" != "" ]; do
		if [ "$OPT_R" == 1 ]; then
			chown -R "$CHOWNER":"$CHOWNER" "$1"
			chmod -R "$CHMODE" "$1"
		else
			chown "$CHOWNER":"$CHOWNER" "$1"
			chmod "$CHMODE" "$1"
		fi
		shift
	done
}

# CHange Ownership and Mode ... of a file at the same time, with root permitions
function rchom {
	OPT_H=0
	OPT_R=0

	while [[ "$1" == -* ]]; do
		if [ "$1" == "-h" ]; then OPT_H=1
		elif [ "$1" == "-r" ]; then OPT_R=1
		else echo "unknown option '$1', ignoring..."; fi
		shift
	done

	if [ "$OPT_H" == 1 ]; then
		echo "rchom: a function that changes both ownership and permitions of 1 or more files or directories at the same time, with root permitions."
		echo "Syntax:   rchom [-h] [-r] (username) (mode) (file|directory)"
		echo "'-r' (recursive) is optional, the rest are required"
		return
	fi

	CHOWNER=$1
	CHMODE=$2

	shift
	shift

	while [ "$1" != "" ]; do
		if [ "$OPT_R" == 1 ]; then
			sudo chown -R "$CHOWNER":"$CHOWNER" "$1"
			sudo chmod -R "$CHMODE" "$1"
		else
			sudo chown "$CHOWNER":"$CHOWNER" "$1"
			sudo chmod "$CHMODE" "$1"
		fi
		shift
	done
}
