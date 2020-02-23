# Switching from OS X to Ubuntu

Having using Windows on a laptop but Unix-systems for work, I switched to OS X nearly 20 years ago, because it offered a good set of desktop applications (like Adobe Creative Suite) while it was also was based around Unix (i.e., the then-new OS X). This gave me the best of both worlds: Desktop apps like Final Cut Pro, but also access to the Terminal. And indeed, I do think OS X is a great Unix-type system. It works smoothly and has a large user-base. However, having come from Unix systems (including SunOS) I had always mapped the CapsLock key to control, with things like like ctrl-a, ctrl-d deeply embedded in muscle memory. Switching to OS X allowed me to retain this: The apple/command key controls window/application functions (like new window) while the ctrl key works (for Terminal, and many other apps) as expected in a Terminal. So that really worked.

I'd been using a range of Macs (both Power PC and Intel, MacBook and MacBook Pro), and eventually a MacBook Air (2011). I had been meaning to replace it, but was held back by their endless keyboard troubles. In late 2018, the new MacBook Air came out (with an apparently improved keyboard), so I bought one. Within two weeks, parts of the keyboard become unreliable in the same way as what happened for other keyboards. The 'new improved' keyboard was once again a failure. So that machine went back. In April 2019, my old MacBook Air (2011) went up in a puff of smoke, forcing my hand. (The SSD stayed intact, and I migrated data to a MacMini 2012.) As even that MacBook Air had not been trouble-free (e.g., many battery replacements) I'd decided that it was time to look elsewhere.

So, in April 2019, I decided to switch away from OS X. As opposed to 20 years ago (when I used many Mac Desktop applications, like Final Cut, Shake, etc etc, and Adobe), I'm now mainly Chrome/Google Drive-based. So my first idea was to use a Chromebook, which have a linux sub-system. There were really two issues with this. One was that the build-quality of the (£500-ish) Chromebooks I tried wasn't all that great, especially the trackpads were a bit ropy. Obviously, the Chromebook market is changing quickly, and it may not be possible to get better machines. But at the time, to get a Chromebook that supported linux and had decent built quality didn't quite work for me. However, the other big issues was the keyboard. Chrome is a two-modifer system, while OS X is a three modifier system. There are things you can do (see https://github.com/bjohas/kromos, https://github.com/bjohas/extra-keyboards-for-chrome-os) but in the end I came up against certain issues (such as the issue that redefining keyboard layouts would work for most keys, but there'd be some keys that seemed to be hard wired, such as speech input to ctrl-d). 

Looking around, I could get a Lenovo Yoga 720 as a Grade A machine for around £500, which seemed like a good way to explore Ubuntu. Ubuntu brings greater flexibility regarding keyboards, but as it turns out, it was still a 10 month journey to actually get OS X keyboard replicated. It sounds simple in principle, but in practice, it was hard. 

# Ubuntu keyboard map like OS X

When switching from OS X to the Ubuntu desktop, you're essentially moving from a three-modifier system (command/alt/ctrl) to a two+1 modifier system (ctrl/alt + super). Super has a special role usually to do with rearranging windows etc. However, in OS X (especially if you use the Terminal) you cannot get away with using all three. In Ubuntu, you could just use ctrl/alt if you didn't have a Super key.

## Operating system and window manager: Ubuntu 19.04/19.10 with Gnome.

These notes here were developed for Ubuntu 19.04/19.10, which uses gnome as the default desktop manager. Previous versions of ubuntu used other desktop managers, and some of these notes will not be applicable.

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

### Description

To get the OS X layout, I've moved the control key nex to space (where the apple/command key would be). For most desktop apps, the behaviour (muscle memory) is now like a Mac. Let's call this key 'thumb'. So in the browser 'thumb-t' opens a new tab, 'thumb-a' selects all etc. So that's great. However, in OS X, you can use the Ctrl-key throughout (Cocoa) for going to the beginning of the line, end of line, cut etc. Let's call this key 'pinky'. I've used autokey to implement those functions, and mapped this to Hyper, physically located where I would expect 'pinky' to be. So now, pinky-a takes me to the beginning of the line, end of line etc etc. So now, my ubuntu desktop works like a mac desktop: I can use thumb and pinky like I would on a mac.

The problem is then just the terminal, where on Ubuntu, ctrl works differently from the Desktop, but where on Mac, it works the same. So what I do in terminal, is I move control to the 'pinky' position. That means, as before, I can now do pinky-a, pinky-e, etc etc. So that's great. However, 'thumb' now doesn't work: On Mac, I can still do thumb-x/c/v to cut/paste etc. So what I do is to move Hyper to the thumb position, and then use autokey again to map common commands.
(In case you're interested, the autokey commands are all described here: https://github.com/bjohas/Ubuntu-keyboard-map-like-OS-X/blob/master/autokey%20scripts.md)

So, this works all pretty simply - and perfectly emulates the Mac Desktop on Ubuntu. The only caveat is that you need to switch the Hyper and Ctrl keys around: The usual position for everything bar Terminal, and swapped round for Terminal.
(Btw., the reason I have used Hpyer but haven't used Super is because Super has default roles in Ubuntu. I'm actually using the Caps-Lock key as 'pinky')

### Implementing this
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
Compared to the above map, it swaps ctrl and hyper (Note: Not quite for the xmodmap, but close enough, see comments below. Note also that I'm undecided about not swapping the keys to the right of SPACE, or maybe placing an alt key there. There are advantages/disadvantages to that.)

The above keyboard layout is that one that I'm used to for the OS-X-terminal, and I can now bind the hyper key to other OS-X-type functions that I might want: Chiefly 
 - x/c/v for copy/cut/paste (via autokey, so that it works in xemacs too), as well as e.g. 
 - t/n/w for new tab / new window / close window in gnome terminal (using the gnome terminal settings). 
 
 If you use (x)emacs, the bindings will also work. See separate page on autokey on how to do this.

## Switching between the two

So now you have two maps. How do you switch between them? 

### Approach 1. Switching keyboard maps with xdotool - workable, but very unreliable

The idea here is to use xdotool to detect window changes and switch keyboard maps accordingly.

#### Approach 1A: XmodmapFollow with xmodmap

The file XmodmapFollow in this repo uses xdotool to detect window changes, and then uses the xmodmaps above to change layout. Turns out that this is very slow. Plus it inherits the bugs of xdotool, so it's really not very stable. (Self-answered question related to this: https://unix.stackexchange.com/questions/535033/executing-command-when-application-comes-to-the-foreground-ubuntu-19-04-x11.)

If you want to try this approach, see 
 - XmodmapFollow.pl here: https://github.com/bjohas/Ubuntu-keyboard-map-like-OS-X/blob/master/scripts/XmodmapFollow.pl  
 - and the two Xmodmap files below: https://github.com/bjohas/Ubuntu-keyboard-map-like-OS-X/tree/master/maps/XmodmapFollow%20with%20xmodmap 
 
However, Approach 1B below is much quicker and more reliable.

#### Appraoch 1B: XmodmapFollow with setxkbmap

As setxkbmap is much faster in applying new keyboard maps than xmodmap, I've put setxkbmap into XmodmapFollow. At least the keyboard switching is faster now, despite the bugs of xdotool.

If you want to try this approach, see 
 - XmodmapFollow.pl here: [XmodmapFollow.pl](scripts/XmodmapFollow.pl)
 - and the enD/enT files here: [maps/v1](maps/v1)

You will also want to adjust your shortcut keys. Initially, this was part of XmodmapFollow.pl. However, using multiple assignments for each combination, it was possible for me to not needing to change those per Window, see [setShortcutsGnome.pl](scripts/setShortcutsGnome.pl) on how to set this up.

This is much quicker and more reliable than Approach 1. However, it still uses Xdotool, which doesn't seem to reliably detect all window switches and/or occasionally stops working altogether. 

Important: Ubuntu 19.10. At least on Ubuntu 19.10, if you are using gnome-tweaks and have used it previously to remap you controil key, make sure that you deselect the ctrl-key remapping. It seems to interfere with approach 4.

#### Conclusion: Not reliable.

Switching keyboard maps with xdotool is workable, but very unreliable. Especially if you're switching between Terminal and another application regularly (e.g. to copy/paste) it fails quickly. Sometimes when it fails, it seems that e.g. the ctrl key 'gets stuck', i.e. just typing 'a' acts as 'ctrl-a' producing unexpected behaviours mid-flow. I set up a keyboard shortcut (Super-Backspace) via Autokey to reset and restart XmodmapFollow which would fix this. Basically, in an average day, I'd have to use this once or twice for sure, but many times perhaps 10 times a day or so. So not a reliable solution at all.

### Approach 2: Use the GUI settings

The Gnome settings (under languages) allow for different layouts per window. This requires xkb. So I developed the xkb files that are in this repo. I initially posed that as a question (here: https://askubuntu.com/questions/1187610/reassigning-modifier-keys-with-xkb/1187783) but also contacted a number of people on github that had done xkb work, and thus arrived at the files here (with some input from @repolho). The problem now is that while the maps work with setxkbmap, with the GUI they don't. 

Keyboard-map related issue: Interaction between __input sources__ switching (“Language and Region”) and setxbkmap
 - https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config/issues/187
 - https://discourse.gnome.org/t/keyboard-map-related-issue-2-interaction-between-input-sources-switching-language-and-region-and-setxbkmap/2130
 - https://gitlab.gnome.org/GNOME/gnome-control-center/issues/782
 - https://askubuntu.com/questions/1187790/xkbmap-works-with-setxkbmap-but-not-in-gui
 - https://askubuntu.com/questions/1187782/why-set-setxkbdmap-work-differently-from-the-gui-keyboard-map-switcher-super-sp

I've also asked via IRC. I hope that I can get this resolved via the above posts/irc... (update 2019-12-01) ... which unfortuntaly hasn't led to conclusive answers, except for some hints on the __Hyper__ key issue, which has now been fixed, see [Hyper key.md](Hyper%20key.md).

The problem seems to be developing a working xkbmap. On Ubuntu 19.04, the provess of copying enT/enD to the xkb directory and modifying evdev.xml showed the maps in the switcher, although they didn't work. However, on Ubuntu 19.10, the maps do not show in the switcher. From reading various articles, it seems that xkbmap isn't very user configurable; to get our maps to work, we'll either need to rebuild xkb, or perhaps figure out what configuration files are missing to make this work.

#### Progress!!

With the help of the people at https://github.com/xkbcommon/libxkbcommon, I made some progress. (Note: https://github.com/xkbcommon/libxkbcommon is not Xorg, but it is an implementation of XKB extracted from Xorg; it's used by Wayland Desktops and others. However, the people know their stuff, and had the following important observation.)

In evdev.xml I had declared `enT` to be a variant of the `us` layout. When this is selected in the GUI, you see thiswith  `setxkbmap -print`:
```
keycodes: evdev+aliases(qwerty)
types:    complete
compat:   complete
symbols:  pc+us(enT)+inet(evdev)
```
The `us(enT)` that the `enT` xkb_symbols section is searched for in the "/usr/share/X11/xkb/symbols/us" file. However, I had put them into a separate file (`enT`). The upshot is that the keymap is not found. 

The solution is to place the new maps into the `us` file. See updated repository here:
- [maps](maps)
-- `us`: The amended `us` keymap. Look at the end to see the new entries.
-- `evdev.xml`: The amended `evdev.xml`; search for hyper.

#### Still stuck (2020-02-23)

See here
https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config/issues/187#note_392832

A write-up of the problem is available here: 
https://docs.google.com/document/d/1KiZN0hBhohqUWo3UXJDx-VAKvlBvJ6y_YyUp5l2nxy0/edit

### Approach 3: Finding another terminal programme: The approach that works!! 

I then searched for a terminal programme that had the ability to remap modifier keys (see https://unix.stackexchange.com/questions/549222/replacement-for-terminal-tilda-guake-terminator-but-with-modifier-key-r). That didn't lead to anything. uxrvt has a perl extension, that maybe would have made that possible.

However, following some discussions here: https://gitlab.gnome.org/GNOME/gnome-terminal/issues/220#note_716221, I was able to recompile the libraries needed for Gnome Terminal to get it to use the Hyper key (instead of control), see write up here: https://github.com/bjohas/Ubuntu-keyboard-map-like-OS-X/blob/master/Building%20a%20Gnome-Hyper-Terminal.md. 


# Links
 
 See [Useful links.md](Useful%20links.md).
