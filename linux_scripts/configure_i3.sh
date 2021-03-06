#!/bin/bash

# Script to configure i3 window manager in Arch Linux
# Does not need to be executed as root.

# Get username
user_name=$(logname)

# Wifi network name
wifi='Miller Homelab'

# Prompts
read -r -p "Have the wifi autoconnect? [y/N] " response1

# Setup Duel Monitors
read -r -p "Is there more than one monitor? [y/N] " monitor_response
if [[ "${monitor_response}" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    xrandr
    read -r -p "Specify the first display. Example 'HDMI-1': " display1
    read -r -p "Specify the second display. Example 'DVI-D-1': " display2
fi

# Install packages
sudo pacman -S --noconfirm --needed i3-wm i3blocks i3lock i3status perl perl-anyevent-i3 perl-json-xs dmenu network-manager-applet blueman pasystray paprefs picom xorg-xrandr

# Setup i3 config
mkdir "/home/${user_name}/.config"
mkdir "/home/${user_name}/.config/i3"
rm -r "/home/${user_name}/.i3"
sudo bash -c "cat <<\EOF > \"/home/${user_name}/.config/i3/config\"
# i3 config file (v4)

# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below.
font pango:monospace 12

# xss-lock grabs a logind suspend inhibit lock and will use i3lock to lock the
# screen before suspend. Use loginctl lock-session to lock your screen.
exec --no-startup-id xss-lock --transfer-sleep-lock -- i3lock --nofork &

# use these keys for focus, movement, and resize directions when reaching for
# the arrows is not convenient
set \$up l
set \$down k
set \$left j
set \$right semicolon

# use Mouse+Mod1 to drag floating windows to their wanted position
floating_modifier Mod1

# start a terminal
bindsym Mod1+Return exec i3-sensible-terminal

# kill focused window
bindsym Mod1+Shift+q kill

# start dmenu (a program launcher)
bindsym Mod1+d exec dmenu_run

# change focus
bindsym Mod1+\$left focus left
bindsym Mod1+\$down focus down
bindsym Mod1+\$up focus up
bindsym Mod1+\$right focus right

# alternatively, you can use the cursor keys:
bindsym Mod1+Left focus left
bindsym Mod1+Down focus down
bindsym Mod1+Up focus up
bindsym Mod1+Right focus right

# move focused window
bindsym Mod1+Shift+\$left move left
bindsym Mod1+Shift+\$down move down
bindsym Mod1+Shift+\$up move up
bindsym Mod1+Shift+\$right move right

# alternatively, you can use the cursor keys:
bindsym Mod1+Shift+Left move left
bindsym Mod1+Shift+Down move down
bindsym Mod1+Shift+Up move up
bindsym Mod1+Shift+Right move right

# split in horizontal orientation
bindsym Mod1+h split h

# split in vertical orientation
bindsym Mod1+v split v

# enter fullscreen mode for the focused container
bindsym Mod1+f fullscreen toggle

# change container layout (stacked, tabbed, toggle split)
bindsym Mod1+s layout stacking
bindsym Mod1+w layout tabbed
bindsym Mod1+e layout toggle split

# toggle tiling / floating
bindsym Mod1+Shift+space floating toggle

# change focus between tiling / floating windows
bindsym Mod1+space focus mode_toggle

# focus the parent container
bindsym Mod1+a focus parent

# focus the child container
#bindsym Mod1+d focus child

# move the currently focused window to the scratchpad
bindsym Mod1+Shift+minus move scratchpad

# Show the next scratchpad window or hide the focused scratchpad window.
# If there are multiple scratchpad windows, this command cycles through them.
bindsym Mod1+minus scratchpad show

# Define names for default workspaces for which we configure key bindings later on.
# We use variables to avoid repeating the names in multiple places.
set \$ws1 \"1\"
set \$ws2 \"2\"
set \$ws3 \"3\"
set \$ws4 \"4\"
set \$ws5 \"5\"
set \$ws6 \"6\"
set \$ws7 \"7\"
set \$ws8 \"8\"
set \$ws9 \"9\"
set \$ws10 \"10\"

# switch to workspace
bindsym Mod1+1 workspace number \$ws1
bindsym Mod1+2 workspace number \$ws2
bindsym Mod1+3 workspace number \$ws3
bindsym Mod1+4 workspace number \$ws4
bindsym Mod1+5 workspace number \$ws5
bindsym Mod1+6 workspace number \$ws6
bindsym Mod1+7 workspace number \$ws7
bindsym Mod1+8 workspace number \$ws8
bindsym Mod1+9 workspace number \$ws9
bindsym Mod1+0 workspace number \$ws10

# move focused container to workspace
bindsym Mod1+Shift+1 move container to workspace number \$ws1
bindsym Mod1+Shift+2 move container to workspace number \$ws2
bindsym Mod1+Shift+3 move container to workspace number \$ws3
bindsym Mod1+Shift+4 move container to workspace number \$ws4
bindsym Mod1+Shift+5 move container to workspace number \$ws5
bindsym Mod1+Shift+6 move container to workspace number \$ws6
bindsym Mod1+Shift+7 move container to workspace number \$ws7
bindsym Mod1+Shift+8 move container to workspace number \$ws8
bindsym Mod1+Shift+9 move container to workspace number \$ws9
bindsym Mod1+Shift+0 move container to workspace number \$ws10

# reload the configuration file
bindsym Mod1+Shift+c reload

# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym Mod1+Shift+r restart

# exit i3 (logs you out of your X session)
bindsym Mod1+Shift+e exec \"i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'\"

# resize window (you can also use the mouse for that)
mode \"resize\" {
    # These bindings trigger as soon as you enter the resize mode
    
    # Pressing left will shrink the window’s width.
    # Pressing right will grow the window’s width.
    # Pressing up will shrink the window’s height.
    # Pressing down will grow the window’s height.
    bindsym \$left       resize shrink width 10 px or 10 ppt
    bindsym \$down       resize grow height 10 px or 10 ppt
    bindsym \$up         resize shrink height 10 px or 10 ppt
    bindsym \$right      resize grow width 10 px or 10 ppt
    
    # same bindings, but for the arrow keys
    bindsym Left        resize shrink width 10 px or 10 ppt
    bindsym Down        resize grow height 10 px or 10 ppt
    bindsym Up          resize shrink height 10 px or 10 ppt
    bindsym Right       resize grow width 10 px or 10 ppt
    
    # back to normal: Enter or Escape or Mod1+r
    bindsym Return mode \"default\"
    bindsym Escape mode \"default\"
    bindsym Mod1+r mode \"default\"
}

bindsym Mod1+r mode \"resize\"

# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
bar {
    status_command i3status
    mode hide
    hidden_state hide
    modifier Mod1
}

exec --no-startup-id bash '/usr/local/bin/i3_autostart.sh'

EOF"

# Setup autostart applications
sudo bash -c "cat <<EOF > '/usr/local/bin/i3_autostart.sh'
#!/bin/bash

# Define path to commands.
PATH=\"/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin\"

termite &
nm-applet &
blueman-applet &
pasystray &
picom &
xsetroot -solid \"#000000\"

EOF"

# Have the wifi autoconnect
if [[ "${response1}" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    sudo cp '/usr/local/bin/i3_autostart.sh' '/tmp/i3_autostart.sh'
    sudo bash -c "awk '/xsetroot -solid \"#000000\"/ { print; print \"nmcli connect up '\"'${wifi}'\"'\"; next }1' '/tmp/i3_autostart.sh' > '/usr/local/bin/i3_autostart.sh'"
fi

# Setup duel monitors
if [[ "${monitor_response}" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    sudo cp '/usr/local/bin/i3_autostart.sh' '/tmp/i3_autostart.sh'
    sudo bash -c "awk '/xsetroot -solid \"#000000\"/ { print; print \"xrandr --output ${display2} --auto --right-of ${display1}\"; next }1' '/tmp/i3_autostart.sh' > '/usr/local/bin/i3_autostart.sh'"
    
fi

# Allow script to be executable.
sudo chmod +x '/usr/local/bin/i3_autostart.sh'
