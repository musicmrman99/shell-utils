# Syntax:
#   @ [[-p] (period-of-time)] ... [command [args]]
#   @ [-t (point-in-time)] ... [command [args]]

function @ {
	# The following is a modified version of this: http://stackoverflow.com/a/246128
	local at_source
	local at_dir

	at_source="${BASH_SOURCE[0]}"

	# resolve $at_source until the file is no longer a symlink
	while [ -h "$at_source" ]; do
		at_dir="$(cd -P "$( dirname "$at_source" )" && pwd)"
		at_source="$(readlink "$at_source")"

		# if $at_source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
		[[ $at_source != /* ]] && at_source="$at_dir/$at_source"
	done
	at_dir="$(cd -P "$( dirname "$at_source" )" && pwd)"

	# ------------------------------------------------------------

	help=false
	period=true
	time=0

	while [ "$(printf '%s' "$1" | head -c 1)" = '-' ]; do
		case "$1" in
			'-h' | '-?' | '--help') help=true;;
			'-p' | '--period')
				if [[ "$2" =~ ^[0-9]+[a-z]?$ ]] && ! [[ "$3" =~ ^[0-9]+[a-z]?$ ]]; then
					time_suffix="$(printf '%s' "$2" | tail -c -1)"
					without_time_suffix="$(printf '%s' "$2" | head -c -1)"
					case "$time_suffix" in
						'y') time=$(( $time + $(( $(date -d "now + $without_time_suffix years" +'%s') - $(date -d 'now' +'%s') )) ));;
						'w') time=$(( $time + $(( $(date -d "now + $without_time_suffix weeks" +'%s') - $(date -d 'now' +'%s') )) ));;
						'd') time=$(( $time + $(( $(date -d "now + $without_time_suffix days" +'%s') - $(date -d 'now' +'%s') )) ));;
						'h') time=$(( $time + $(( $(date -d "now + $without_time_suffix hours" +'%s') - $(date -d 'now' +'%s') )) ));;
						'm') time=$(( $time + $(( $(date -d "now + $without_time_suffix minutes" +'%s') - $(date -d 'now' +'%s') )) ));;
						's' | [0-9]*) time=$(( $time + $(( $(date -d "now + $without_time_suffix seconds" +'%s') - $(date -d 'now' +'%s') )) ));;
						*)
							echo "Error: '--period': unknown time suffix: '$time_suffix'"
							return 1
					esac
				else
					echo "Error: '--period' takes one argument: 'period'"
					return 1
				fi
				shift
				;;

			'-t' | '--time')
				if [ "$2" != '' ]; then
					"$(date -d "$2" +%s)"
					if [ $? = 1 ]; then
						echo "Error: invalid argument to '--time': '$2'"
						return 1
					fi

					time=$(( $time + ($(date -d "$2" +%s) - $(date -d now +%s)) ))
				else
					echo "Error: '--time' takes one argument: 'time'"
					return 1
				fi
				shift
				;;

			*)
				echo "unrecognised option: '$1'"
				return 1
		esac
		shift
	done

	if [ "$help" = true ]; then
		cat "$at_dir/help/@.help.txt"
		return 0
	fi

	if (( "$time" < 0 )); then
		echo "Error: $time seconds is before now"
		return 1
	fi

	start="$(date -d "now" +'%s')"
	printf '%s:\n  %s\n' "Start Time" "$(date -d "1970-01-01 $(($start)) sec GMT" +'%a %d %B %Y - %H:%M:%S')"
	printf '%s:\n  %s\n' "Expected End Time" "$(date -d "1970-01-01 $(($start + $time)) sec GMT" +'%a %d %B %Y - %H:%M:%S')"
	printf '%s\n' '<sleep>'
	sleep "$time"
	printf '%s:\n  %s\n' "Actual End Time" "$(date -d 'now' +'%a %d %B %Y - %H:%M:%S')"
	printf '%s\n' '<exec>'
	("$@")
	printf '%s:\n  %s\n' "Time After Exec" "$(date -d 'now' +'%a %d %B %Y - %H:%M:%S')"
	printf '%s\n' '<done>'
}
