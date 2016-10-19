#!/bin/sh

PATH=/usr/local/bin:$PATH

# figure out if we have multi-monitor setup
$HOME/bin/reset-display

# toggle touchpad
$HOME/bin/toggle-trackpad

# need to switch to powersave mode once, after we login
sudo cpufreq-set --governor powersave

# grab my X-settings
xrdb .Xdefaults

# power saver mode
# set 60 seconds more for blanking out the monitor than the xwrits
# breaktime period
xset dpms 360 600 900

# set the background to black
xsetroot -solid Black
#nice -19 xplanet -origin sun -target earth -radius 70 -transparency -idlewait 120 -wait 900 -fork

# dim the display
xbacklight -set 10

VERSA_BLR_LAT=12.970699
VERSA_BLR_LON=77.598376
redshift -l $VERSA_BLR_LAT:$VERSA_BLR_LON -g 0.5 -m vidmode &

# battery
xbattbar -c &

# rsi
#xwrits typetime=40 breaktime=5 +mouse +beep +breakclock & disown

# screensavers
#xscreensaver &

# dwm status bar
while true; do
    xsetroot -name "$( dwm_status.py )"
    sleep 10
done &

# start window manager with ssh-agent
#(ssh-agent ratpoison) & wmpid=$!
(ssh-agent dwm) & wmpid=$!

# wait for the window manager process to exit
wait $wmpid
