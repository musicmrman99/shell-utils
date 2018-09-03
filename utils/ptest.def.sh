# Print the result of the test.
function ptest {
	test "$@"
	local result="$?"

	if [ "$result" = 0 ]; then
		printf 'true'
	elif [ "$result" = 1 ]; then
		printf 'false'
	else
		printf 'Error: %s' "test returned error: $result"
	fi
}
