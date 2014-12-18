#!/bin/sh

PATH=/usr/local/bin:$PATH

# grab my X-settings
xrdb .Xdefaults

# power saver mode
# set 60 seconds more for blanking out the monitor than the xwrits
# breaktime period
xset dpms 360 600 900

# set the background to black
xsetroot -solid Black
#nice -19 xplanet -origin sun -target earth -radius 70 -transparency -idlewait 120 -wait 900 -fork

# rsi
#xwrits typetime=40 breaktime=5 +mouse +beep +breakclock & disown

# screensavers
#xscreensaver &

# dwm status bar
while true; do
   xsetroot -name "$( date +"%a %d %b %Y %H:%M" )"
   sleep 60    # Update time every minute
done &

# start window manager with ssh-agent
#(ssh-agent ratpoison) & wmpid=$!
(ssh-agent dwm) & wmpid=$!

# wait for the window manager process to exit
wait $wmpid
