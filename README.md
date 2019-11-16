# Ubuntu keyboard map like OS X

When switching from OS X to the Ubuntu desktop, you're essentially moving from a three-modifier system (command/alt/ctrl) to a two modifier system (ctrl/alt). 

## Operating system and window manager

These notes here were developed for Ubuntu 19.04, which uses gnome as the default desktop manager. Previous versions of ubuntu used other desktop managers, and some of these notes will not be applicable.

## Overall keyboard shortcuts: gsettings

Many keyboard shortcuts can be configured via Settings and more settings can be controlled by the gnome tweaks tool. It's a good idea to go through the list in the Settings application (keyboard section) and look at the available keys. Super-L/R/U/D are very helpful (and require an extension on OS X). Screenshot keyboard shortcuts can be set here too.

However, this doesn't have all keyboard shortcuts. You can list all settings via gsettings, see gsettings-show.pl in this repo. In particular, the emoji key (set to ctrl+shift+e which conflices with Google Docs) took a bit of tracking down: 

    gsettings-show.pl  | grep emoji

(self-answered question here: https://unix.stackexchange.com/questions/534044/which-system-files-configure-global-keyboard-shortcuts/551458; also here https://unix.stackexchange.com/questions/532481/how-do-you-change-systems-wide-keyboard-short-cuts-on-the-commandline-e-g-shi).

However, there's a bunch of muscle memory invested in other keyboard shortcuts.

## Sorting out non-modifier keys (a UK specific problem)

The UK-Mac keyboard is basically a US keyboard with extra keys, so (as I'm touch typing), I've loaded the US keyboard in Ubuntu. This means you have your usual keys (bar some deliberation over £ vs. #). The next change is to place the ctrl key next to space: There are options available in Gnome Tweaks. For the desktop, this means that the Ubuntu desktop works pretty much like the OS X desktop, as long as you don't need to use OS-X-Ctrl and your not in the Ubuntu Terminal.


## Setting up the Ubuntu-desktop modifer keys so that they work like OS X

For me, it was quite natural to move the Ubuntu-control key next to the spacebar, as it then essentially works the same as the OS-X-command key (next to the spacebar). I.e., things like copy/cut/paste as well as new tab etc work without retraining muscle memory.

I started to explore this "OS X to Ubuntu while preserving muscle memory" quest on the forums, but without much luck (self-answere questions: https://askubuntu.com/questions/1150482/ubuntu-desktop-with-bash-keyboard-shortcuts/1187814, https://askubuntu.com/questions/1160090/xmodmap-and-keyboard-shortcuts-how-does-the-system-work-19-04-xorg). It seems kinda obvious to me that people might move from OS X to Ubuntu or vice versa. Or that one would want to get a consistent use of the Ctrl key across Ubuntu. However, this was difficult to find (as the many posts show).

So, how far can we get with this? As just noted, placing the Ubuntu-Ctrl key next to space helps. However, the OS-X-ctrl key works - for many OS-X-applications - works like the Ubuntu-terminal ctrl key. However, clearly this doesn't work on the Ubuntu desktop. (Strange to think that OS X has a consistent set of keybindings across desktop and terminal, while Ubuntu doesn't.) The way to fix this is to use the Ubuntu-Hyper key, which doesn't seem to be widely used. By placing the Ubuntu-Hyper key where you expect your OS-X-ctrl key, you can then create additional functions (e.g., in autokey) that emulate the OS-X-Desktop behaviour.

In this repo, try
    Xmodmap xmodmap_desktop
or
    setxkbmap enD
(The latter command requires copying of the enD/enT files to /usr/share/X11/xkb/symbols. Note that as of the time of writing - 2019-11-10 - it seems that xkb cannot work of a local directory.)

The above commands change the layout from
    caps
    SHIFT
    ctrl FN windows Alt SPACE AltGr ctrl
to
    hyper
    SHIFT
    super FN alt ctrl SPACE ctrl hyper
The keys that haven't changed are in caps. (Note: Not quite for the xmodmap, but close enough, see comments below.) 
    
If you then bind the hyper-a/e/d/k etc to beginning/end of line, delete char, cut to end of line (e.g. using autokey) you have an OS-X-desktop like binding.  See separate page on autokey on how to do this.

(Of course you can reorder the keys as you like - in OS X I've had the ctrl/caps key swapped forever.)

## Setting up the Ubuntu-Terminal shortcuts so that they work like OS X

However, this now leaves the keyboard bindings for the Ubuntu-Terminal (esp. emacs) quite different from muscle memory.

Using the files from this repo, try
    Xmodmap xmodmap_terminal
or
    setxkbmap enT

This changes the layout to
    ctrl
    SHIFT
    super FN alt hyper SPACE ctrl hyper
Compared to the above map, it swaps ctrl and hyper (Note: Not quite for the xmodmap, but close enough, see comments below. Nonte also that I'm undecided about not swapping the keys to the right of SPACE, or maybe placing an alt key there. There are advantages/disadvantages to that.)

The above keyboard layout is that one that I'm used to for the OS-X-terminal, and I can now bind the hyper key to other OS-X-type functions that I might want: Chiefly 
 - x/c/v for copy/cut/paste (via autokey, so that it works in xemacs too), as well as e.g. 
 - t/n/w for new tab / new window / close window in gnome terminal (using the gnome terminal settings). 
 
 If you use (x)emacs, the bindings will also work. See separate page on autokey on how to do this.

## Switching between the two

So now you have two maps. How do you switch between them? 

### Approach 1: XmodmapFollow with xmodmap

The file XmodmapFollow in this repo uses xdotool to detect window changes, and then uses the xmodmaps above to change layout. Turns out that this is very slow. Plus it inherits the bugs of xdotool, so it's really not very stable. (Self-answered question related to this: https://unix.stackexchange.com/questions/535033/executing-command-when-application-comes-to-the-foreground-ubuntu-19-04-x11.)

If you want to try this approach, see 
 - XmodmapFollow.pl here: https://github.com/bjohas/Ubuntu-keyboard-map-like-OS-X/blob/master/scripts/XmodmapFollow.pl  
 - and the two Xmodmap files below: https://github.com/bjohas/Ubuntu-keyboard-map-like-OS-X/tree/master/maps/XmodmapFollow%20with%20xmodmap 
 
However, Approach 4 below is much quicker and more reliable.

### Approach 2: Finding another terminal programme 

I then searched for a terminal programme that had the ability to remap modifier keys (see https://unix.stackexchange.com/questions/549222/replacement-for-terminal-tilda-guake-terminator-but-with-modifier-key-r). That didn't lead to anything. uxrvt has a perl extension, that maybe would have made that possible.

### Approach 3: Use the GUI settings

I then found that the settings (under languages) allows for different layouts per window. This requires xkb. So I developed the xkb files that are in this repo. I initially posed that as a question (here: https://askubuntu.com/questions/1187610/reassigning-modifier-keys-with-xkb/1187783) but also contacted a number of people on github that had done xkb work, and thus arrived at the files here (with some input from @repolho). The problem now is that while the maps work with setxkbmap, with the GUI they don't. 

Here are the two issues posted on various forums:

Keyboard-map related issue: hyper key not working in gsettings for “org.gnome.desktop.wm.keybindings *window/app*”
 - https://discourse.gnome.org/t/keyboard-map-related-issue-hyper-key-not-working-in-gsettings-for-org-gnome-desktop-wm-keybindings-window-app/2129
 - https://gitlab.gnome.org/GNOME/gnome-control-center/issues/778
 - https://askubuntu.com/questions/1187790/xkbmap-works-with-setxkbmap-but-not-in-gui

Keyboard-map related issue 2: Interaction between input sources switching (“Language and Region”) and setxbkmap
 - https://discourse.gnome.org/t/keyboard-map-related-issue-2-interaction-between-input-sources-switching-language-and-region-and-setxbkmap/2130
 - https://gitlab.gnome.org/GNOME/gnome-control-center/issues/782
 - https://askubuntu.com/questions/1187782/why-set-setxkbdmap-work-differently-from-the-gui-keyboard-map-switcher-super-sp

I've also asked via IRC. I hope that I can get this resolved via the above posts/irc... 

### Appraoch 4: XmodmapFollow with setxkbmap

As setxkbmap is much faster in applying new keyboard maps than xmodmap, I've put setxkbmap into XmodmapFollow. At least the keyboard switching is faster now, despite the bugs of xdotool.

If you want to try this approach, see 
 - XmodmapFollow.pl here: https://github.com/bjohas/Ubuntu-keyboard-map-like-OS-X/blob/master/scripts/XmodmapFollow.pl  
 - and the enD/enT files here: https://github.com/bjohas/Ubuntu-keyboard-map-like-OS-X/tree/master/maps/
 
This is much quicker and more reliable than Approach 1.

