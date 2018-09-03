alias iotop='sudo iotop -o -P -k'
alias iftop='sudo iftop -i eth0 -m 400K -P'
alias htop='wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz && htop -d 5' # maximize the window, then run htop
alias htop-term='xfce4-terminal -T htop -e "htop -d 5"; sleep 0.5; wmctrl -r htop -b add,maximized_vert,maximized_horz' # open a terminal, run htop in it, then maximize the new window

alias psa='ps -ef'
alias psu='ps -fU $USER'
