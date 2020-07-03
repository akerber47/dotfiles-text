#
# ~/.bashrc
#
# NOTE not the same as my local machine bashrc! Has some extra sourced
# files, see below:

export PAGER=less
export LESS=-X
export EDITOR=vim
export VISUAL=vim
export SVN_EDITOR=vim

# Force interactive rm, cp, and mv for safety.
alias ls='ls -F --color=always'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Set tty options.
stty sane
stty stop undef # Ctrl+S for forward history search

# Set shell to vi mode
set -o vi

# See bashrcgenerator.com
# prompt is user@host:[pwd](rev) $
# (with some highlighting)
# Pieces:
# user@host:[pwd]

export PS1="\[$(tput bold)\]\u@\H:[\w]"

# final $
export PS1=${PS1}' \$ '
