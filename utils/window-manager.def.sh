# Note: '__arg' is defined in "$BASH_LIB_ROOT/src/src.def.sh" - should it be, or "$BASH_LIB_ROOT/src/arg.def.sh"?
#function wm {
#	__arg
#}

alias maximize='wmctrl -r :ACTIVE: -b toggle,maximized_vert,maximized_horz' # Maximize / Unmaximize the currently active window
alias always-maximize='wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz' # Maximize the currently active window
alias fullscreen='wmctrl -r :ACTIVE: -b toggle,fullscreen' # Toggle Fullscreen for the currently active window
alias set-above='wmctrl -r :ACTIVE: -b add,above' # Set the currently active window as 'above other windows'
alias set-below='wmctrl -r :ACTIVE: -b add,below' # Set the currently active window as 'below other windows'

# If one of these has a naming collision, which is unlikely, then comment it out and use the full 'set' version instead.
alias mx='maximize'
alias mxa='always-maximize'
alias fs='fullscreen'
alias aow='set-above'
alias bow='set-below'
