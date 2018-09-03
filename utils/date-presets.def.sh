# 'date' command presets:
alias date-time='date "+%H:%M:%S"'
alias date-date='date "+%Y-%m-%d"'
alias date-full='date "+%a, %d %b %Y, %I:%M:%S %^p"'

alias date-timestamp='date +"%Y-%m-%d--%H-%M-%S.%6N"'

# Every valid, useful, non-duplicate piece of information available in GNU `date`.
alias date-all='date +"
Day Name: %A
Day Short Name: %a
Day Of Week: %u
Day Of Month: %d
Day Of Year: %j
Week Of Year: %W
Month Of Year: %m
Month Name: %B
Month Short Name: %b
Year: %Y

Date (DD-MM-YYYY): %d-%m-%Y
Date (YYYY-MM-DD): %Y-%m-%d
Time (24h): %H:%M:%S
Time (12h): %I:%M:%S %P

Timezone: %z
"'
