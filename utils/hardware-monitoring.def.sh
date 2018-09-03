# Print out the temprature of the hdd coresponding to the given hdd device file id.
# A valid id contains the following (as a regex): '[a-z][0-9]{0,2}') (sample output (not including quotes): '21°C')
function hddtemp {
	sudo /usr/sbin/hddtemp /dev/sd"$1" | awk -F' ' '{print $3}'
}
