Here's how to build a Gnome Terminal that uses Hyper instead of Ctrl.

Thank you to Egmont Koblinger @egmontkob and Christian Persch @chpe: 
https://gitlab.gnome.org/GNOME/gnome-terminal/issues/220

On Ubuntu 19.10 (Gnome shell) install dependencies:
```
sudo apt install meson
sudo apt install glib2.0
sudo apt install libpango1.0-dev
sudo apt install libgnutls28-dev
sudo apt install cmake
sudo apt install gtk+-3.0
sudo apt install libsystemd-dev
sudo apt install gobject-introspection
sudo apt install libgirepository1.0-dev
sudo apt install valac
sudo apt install gettext
```
Then the following worked (as per README.md):
```
$ meson _build       
$ ninja -C _build   
```
E.g. this works:
```
_build/src/app/vte-2.91
```
and work with the usual keybindings.

Now switch the masks. GDK_CONTROL_MASK occurs in these files:
```
app/app.cc vte.cc vtegtk.cc keymap.cc
```
Replace with GDK_HYPER_MASK
```
perl -pi.bak__$date -e 's/GDK_CONTROL_MASK/GDK_$ARGV[0]_MASK/' app/app.cc vte.cc vtegtk.cc keymap.cc
```
One more edit: In vte.cc, comment out in vte.cc the 8 lines of code containing the "Keypress taken by IM" debug text. It's a single block of 8 lines, you'll see it. (Alternative: `export GTK_IM_MODULE=xim` before starting vte-2.91).

Now run
```
_build/src/app/vte-2.91
```
and voila, the hyper key now plays the role of the ctrl key.

Now - if you're happy so far - let's adjust gnome terminal in the same way. (The vte-2.91 app no longer matters.) To use this in gnome terminal, we need to move `libvte-2.91.so.0.(version)` into the right place. You can check where gnome terminal looks for the libraries as follows:
```
ldd /usr/bin/gnome-terminal.real | grep vte
```
Then run
```
meson --reconfigure --prefix /usr/local/lib --libdir /usr/local/lib _build/
sudo ninja -C _build install
```
Close gnome terminal, reopen.

If you use keyboard short-cuts, you may have set these to using Super/Hyper etc. If you're going for an OS X-type terminal experience, here's how. Given that Ctrl is now free up (as you're using Hyper), you can now use the Ctrl key in your preferences:

![Gnome Terminal Preferences](https://raw.githubusercontent.com/bjohas/Ubuntu-keyboard-map-like-OS-X/master/Building%20a%20Gnome-Hyper-Terminal-Preferences.png)

# Resolving the ibus issue

We believe that the following is a bug in ibus XOR gtk. If the keypress event contains GDK_HYPER_MASK as a modifier, gtk_im_context_filter_keypress() returns true, reporting that the IM handled the event, even though it did not, therefore it should return false.

Background: We are working on modifying Gnome-Terminal / libvte-2.91.so.0 to enable Terminal-bespoke remapping of modifier keys. This is to facilitate OS X users to migrate to Ubuntu. (Discussion here: #220. Background and unsuccessful alternative approaches detailed here: https://github.com/bjohas/Ubuntu-keyboard-map-like-OS-X/blob/master/README.md).
When we replace GDK_CONTROL_MASK by GDK_HYPER_MASK, the input method (ibus) reports that it handled the event that had Hyper as the modifier. When we use export GTK_IM_MODULE=xim, the Hyper modifier is passed as expected. This leads us to believe that this is bug in ibus or perhaps gtk.

Unfortunately I'm not sure whether this is an issue in ibus or gtk, so I'm reporting it in both places (as well as upstream). Apologies for the inconvenience caused by this. Many thanks for looking at this.

I'll track updates here
https://gitlab.gnome.org/GNOME/gnome-terminal/issues/220
and here
https://github.com/bjohas/Ubuntu-keyboard-map-like-OS-X/blob/master/Building%20a%20Gnome-Hyper-Terminal.md
so that people compinging Gnonme Terminal are aware of the status.

https://launchpad.net/ubuntu/+source/ibus/+bugs
https://launchpad.net/ubuntu/+source/gtk+3.0/+bugs
https://bugs.launchpad.net/ibus
https://launchpad.net/gtk
