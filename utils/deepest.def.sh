# Syntax:
#   deepest [-l|-p] (directory)

# Description:
#   Find the deepest (or joint-deepest) path in the given directory and print both
#   the path and its depth. This is the total number of path components, including
#   components given as part of directory, eg.
#     $ deepest ./tmp
#     Depth: 5
#     ./tmp/this/that/other

# Options:
#   -h, -?, --help    print this help message
#   -p, --path        only print the deepest (or joint-deepest) path
#   -l, --length      only print the length of the deepest path

function deepest {
	# The following is a modified version of this: http://stackoverflow.com/a/246128
	local deepest_source
	local deepest_dir

	deepest_source="${BASH_SOURCE[0]}"

	# resolve $deepest_source until the file is no longer a symlink
	while [ -h "$deepest_source" ]; do
		deepest_dir="$(cd -P "$( dirname "$deepest_source" )" && pwd)"
		deepest_source="$(readlink "$deepest_source")"

		# if $deepest_source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
		[[ $deepest_source != /* ]] && deepest_source="$deepest_dir/$deepest_source"
	done
	deepest_dir="$(cd -P "$( dirname "$deepest_source" )" && pwd)"

	# ------------------------------------------------------------

	local action='print_all'

	# Parse arguments
	while [ "$(printf '%s' "$1" | head -c 1)" = '-' ]; do
		case "$1" in
			'-h' | '-?' | '--help') action='help';;
			'-p' | '--path') action='print_path';;
			'-l' | '--length') action='print_length';;

			*)
				printf "unrecognised option: '%s'" "$1"
				printf '%s\n' "See 'deepest -h' for help."
				return 1
				;;
		esac
		shift
	done

	# Perform help action (if given)
	case "$action" in
		'help')
			cat "$deepest_dir/help/deepest.help.txt"
			;;
	esac

	# Perform main action
	paths="$(find "$1" -type f 2>/tmp/deepest--find-errors.txt)"
	case "$action" in
		'print_all')
			printf '%s' "$paths" | awk -F'/' 'NF > depth {
				depth = NF;
				deepest = $0;
			}
			END {
				print "Depth:", depth;
				print deepest;
			}'

			if [ -s /tmp/deepest--find-errors.txt ]; then
				printf '%s\n' '' "WARNING: Some files/directories could not be accessed - this result may not be correct."
			fi
			;;

		'print_path')
			printf '%s' "$paths" | awk -F'/' 'NF > depth {
				depth = NF;
				deepest = $0;
			}
			END {
				print deepest;
			}'
			;;

		'print_length')
			printf '%s' "$paths" | awk -F'/' 'NF > depth {
				depth = NF;
			}
			END {
				print "Depth:", depth;
			}'
			;;

		*)
			printf "unrecognized action: '%s'\n" "$action"
			return 1
			;;
	esac

	rm /tmp/deepest--find-errors.txt
}
