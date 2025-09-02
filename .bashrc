#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.alias_bashrc
source ~/.function_bashrc
export PATH="~/bin:$PATH"

if [[ $USER="isaak" ]]; then
  PS1="[\[\e[0;31m\]@\h\[\e[0m\] \[\e[1;35m\]\W\[\e[0m\] \$]"
else
  PS1="[\[\e[0;31m\]\u\[\e[0m\]@\h\[\e[0m\] \[\e[1;35m\]\W\[\e[0m\] \$]"
fi
echo "Welcome"
