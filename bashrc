# ~/.bashrc

# This file has common stuff that is required for both .bash_profile and .bashrc
# is not executed in login shell.

################################################################################
# Environment variables
export PATH=$HOME/bin:/usr/local/bin:/bin:/usr/X11R6/bin:/usr/bin:/usr/sbin:/sbin
export HISTFILE=$HOME/.history
export HISTFILESIZE=50000
export HISTSIZE=50000
export SAVEHIST=50000
export EDITOR='vim'
export PAGER=less
export TMPDIR=/tmp
export PS1="\u@\h:\w\$ "

# the below colors are for linux
#export LS_COLORS="no=00:fi=00:di=00;33:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:"
# colors for freebsd
export LSCOLORS="DxFxCxDxBxEGEDABAGACAD"
export LC_ALL=C

################################################################################
# Functions (do this first, as we need rehash-workdirs later)
source ~/.bash/functions

################################################################################
# Aliases
source ~/.bash/aliases

# screen list
source ~/.bash/screen-list

################################################################################
# Reload History
history -r

################################################################################
# Local settings
[ -f $HOME/.bash/$HOSTNAME ] && source ~/.bash/$HOSTNAME

################################################################################
# Juniper settings
# Execute this only if we have terminal
test -t 0 && source ~/.bash/jnpr

################################################################################
# SSH Agent
test -t 0 && ( eval `ssh-agent.sh` && $_DOT_PROFILE ssh-agent.sh --link )

################################################################################
# List active screens if not within screen already
test -t 0 && [ -z "$STY" ] && screen -ls
