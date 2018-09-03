function anotify {
	# The following is a modified version of this: http://stackoverflow.com/a/246128
	local anotify_source
	local anotify_dir

	anotify_source="${BASH_SOURCE[0]}"

	# resolve $anotify_source until the file is no longer a symlink
	while [ -h "$anotify_source" ]; do
		anotify_dir="$(cd -P "$( dirname "$anotify_source" )" && pwd)"
		anotify_source="$(readlink "$anotify_source")"

		# if $anotify_source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
		[[ $anotify_source != /* ]] && anotify_source="$anotify_dir/$anotify_source"
	done
	anotify_dir="$(cd -P "$( dirname "$anotify_source" )" && pwd)"

	# ------------------------------------------------------------

	local help=false
	local keep_output=false
	local disown_audio=false

	# Default to an audio source of a program installed by default
	# in Xubuntu (certainly >= 15.04, although I believe long
	# before as well).
	local audio_source='pidgin'

	while [ "$(printf '%s' "$1" | head -c 1)" = '-' ]; do
		case "$1" in
			'-h' | '-?' | '--help') help=true;;
			'-k' | '--keep-output') keep_output=true;;
			'-d' | '--disown-audio') disown_audio=true;;
			'-s' | '--source')
				audio_source="$2"
				shift
				;;

			'--') shift; break;;
			*)
				echo "unrecognised option: '$1'"
				return 1
		esac
		shift
	done

	if [ "$help" = true ]; then
		cat "$anotify_dir/help/anotify.help.txt"
		return 0
	fi

	if [ "$keep_output" = false ]; then
		# from here on:
		#   &0 = stdin
		#   &1 = /dev/null
		#   &2 = /dev/null
		#   &3 = stdout
		#   &4 = stderr
		exec 3>&1 4>&2 1>/dev/null 2>&1
	else
		# from here on:
		#   &0 = stdin
		#   &1 = stdout
		#   &2 = stderr
		#   &3 = >&1
		#   &4 = >&2
		exec 3>&1 4>&2
	fi

	local cmd
	if [ "$disown_audio" = true ]; then
		cmd="disown"
	else
		cmd="fg"
	fi

	# 'aplay is a command-line audio file player for the ALSA sound card driver.'
	#   - wikipedia (retrieved: 11:15am, Monday 22 January 2015)
	# What this means I'll leave up to you to figure out.

	case "$audio_source" in
		'pidgin-send') aplay "/usr/share/sounds/purple/send.wav" & $cmd;;
		'pidgin-receive') aplay "/usr/share/sounds/purple/receive.wav" & $cmd;;
		'pidgin')
			aplay "/usr/share/sounds/purple/send.wav" & $cmd
			aplay "/usr/share/sounds/purple/receive.wav" & $cmd
			;;

		'danger') aplay "$anotify_dir/data/anotify/danger.wav" & $cmd;;
		'warning') aplay "$anotify_dir/data/anotify/warning.wav" & $cmd;;
		'notify') aplay "$anotify_dir/data/anotify/notify.wav" & $cmd;;

		*)
			echo "Error: unknown audio source: $audio_source" 1>&3
			return 1
	esac

	if [ "$1" != '' ]; then
		notify-send "$@"
	fi

	# then reset to default
	if [ "$keep_output" = false ]; then
		exec 1>&3 2>&4 3>&- 4>&-
	else
		exec 3>&- 4>&-
	fi
}
