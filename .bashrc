#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f "~/.function"]; then
  source ~/.function

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'
alias LS='ls -la'
alias c='clear'
alias grepc='grep --color=auto'
PS1="[\[\e[0;33m\]\u\[\e[0m\]@\h\[\e[0m\] \[\e[1;35m\]\W\[\e[0m\] \$]"
