alias sag='sudo apt-get'
alias sagi='sudo apt-get install'
alias sagr='sudo apt-get remove'
alias saga='sudo apt-get autoremove'
alias sagp='sudo apt-get purge'
alias sagupd='sudo apt-get update'
alias sagupg='sudo apt-get upgrade'
alias sagdupg='sudo apt-get dist-upgrade'

alias acs='apt-cache search'
alias acsh='apt-cache show'
alias acp='apt-cache policy'

# modified from here ('accepted' answer - inc. 'linux-libc-dev:amd64' exclusion fix):
#   https://askubuntu.com/questions/142926/cant-upgrade-due-to-low-disk-space-on-boot
# modifications:
#   put into an alias
#   escape the '!'s outside of double quotes (or bash will produce an error)
alias list-kernels="dpkg -l 'linux-*' | sed '/^ii/"\!"d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/"\!"d;/^linux-\(headers\|image\)/"\!"d'"
