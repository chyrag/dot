# ~/.bash_profile

# This is executed for login shells.
test -t 0 && ( stty -ixon; cat -n $HOME/.todo; mesg n; if [ ! -d /tmp/chirag ]; then mkdir /tmp/chirag; rm -f $HOME/tmp; ln -s /tmp/chirag $HOME/tmp; fi)

# basic path, just to get the .bashrc executed
PATH=$HOME/bin:/bin:/usr/bin

# Start ssh-agent if not yet started
export _DOT_PROFILE=:
eval `ssh-agent.sh`

# Get variable settings from .bashrc
source ~/.bashrc
