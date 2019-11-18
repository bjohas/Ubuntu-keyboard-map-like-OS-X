Previously, I had this keyboard-map related issue:

Keyboard-map related issue: __hyper key__ not working in gsettings for “org.gnome.desktop.wm.keybindings *window/app*”
 - https://unix.stackexchange.com/questions/552680/why-does-hypertab-not-work-tested-in-ubuntu-gnome-and-xfce
 - https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config/issues/186
 - https://discourse.gnome.org/t/keyboard-map-related-issue-hyper-key-not-working-in-gsettings-for-org-gnome-desktop-wm-keybindings-window-app/2129
 - https://gitlab.gnome.org/GNOME/gnome-control-center/issues/778
 - https://askubuntu.com/questions/1188046/setting-gnome-window-switching-to-hyper-doesnt-work

This has now been fixed. Here's what the problem was:
- The modifier map settings are incremental.
- There was a Hyper key set among the Super keys. Also, mod5 was already to set ISO_Level3_Shift and Mode_switch. I guess meant the Hyper key didn't fire alone, but along e.g. ISO_Level3_Shift.

There's probably a better solution by understanding xkb from the ground up. However, moving the Hyper_L/R binding to mod3 (leaving mod5 untouched) and then changing <HYPE> to Super seems to work.

New kbd maps availalbe [here](maps). Look for changes made 2019-11-18 to see exactly what changed.
