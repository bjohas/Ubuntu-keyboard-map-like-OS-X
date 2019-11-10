# Ubuntu-keyboard-map-like-OS-X

When switching from OS X to the Ubuntu desktop, you're essentially moving from a three-modifier system (command/alt/ctrl) to a two modifier system (ctrl/alt). 

## Setting up the Ubuntu-desktop shortcuts so that they work like OS X

For me, it was quite natural to move the Ubuntu-control key next to the spacebar, as it then essentially works the same as the OS-X-command key (next to the spacebar). I.e., things like copy/cut/paste as well as new tab etc work without retraining muscle memory.

The UK-Mac keyboard is basically a US keyboard with extra keys, so (as I'm touch typing), I've also loaded the US keyboard. For the desktop, this means that the Ubuntu desktop works pretty much like the OS X desktop, bar the OS-X-ctrl key, which for many OS-X-applications works like the Terminal ctrl key. However, clearly this doesn't work in Ubuntu. (Strange to think that OS X has a consistent set of keybindings across desktop and terminal, while Ubuntu doesn't.) The way to fix this is to use the Ubuntu-Hyper key, which doesn't seem to be widely used. By placing the Ubuntu-Hyper key where you expect your OS-X-ctrl key, you can then create additional functions (e.g., in autokey) that emulate the OS-X-Desktop behaviour.

In this repo, try
    Xmodmap xmodmap_desktop
or
    setxkbmap enD
(The latter command requires copying of the enD/enT files to /usr/share/X11/xkb/symbols.)

This moves the layout from
    caps
    SHIFT
    ctrl FN windows Alt SPACE AltGr ctrl
to
    hyper
    SHIFT
    super FN alt ctrl SPACE ctrl hyper
(Note: Not quite for the xmodmap, but close enough, see comments below.)
    
If you then bind the hyper-a/e/d/k etc to beginning/end of line, delete char, cut to end of line (e.g. using autokey) you have an OS-X-desktop like binding.

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
(Note: Not quite for the xmodmap, but close enough, see comments below.)

This is the keyboard I'm used to for the OS-X-terminal, and I can now bind the hyper key to other functions that I mind want: Chiefly x/c/v for copy/cut/paste, as well as e.g. t for new tab in terminal. If you use xemacs, the bindings will also work.

## Switching between the two

So now you have two maps. How do you switch between them? 

### Approach 1: XmodmapFollow with xmodmap

The file XmodmapFollow in this repo uses xdotool to detect window changes, and then uses the xmodmaps above to change layout. Turns out that this is very slow. Plus it inherits the bugs of xdotool, so it's really not very stable.

### Approach 2: Finding another terminal programme 

I then searched for a terminal programme that had the ability to remap modifier keys (see https://unix.stackexchange.com/questions/549222/replacement-for-terminal-tilda-guake-terminator-but-with-modifier-key-r). That didn't lead to anything. uxrvt has a perl extension, that maybe would have made that possible.

### Approach 3: Use the GUI settings

I then found that the settings (under languages) allows for different layouts per window. This requires xkb. So I developed the xkb files that are in this repo. I initially posed that as a question (here: https://askubuntu.com/questions/1187610/reassigning-modifier-keys-with-xkb/1187783) but also contacted a number of people on github that had done xkb work, and thus arrived at the files here (with some input from @repolho).  

The problem now is that while the maps work with setxkbmap, with the GUI they don't (https://askubuntu.com/questions/1187790/xkbmap-works-with-setxkbmap-but-not-in-gui, also see https://askubuntu.com/questions/1187782/why-set-setxkbdmap-work-differently-from-the-gui-keyboard-map-switcher-super-sp). I hope that I can get this resolved.

### Appraoch 4: XmodmapFollow with setxkbmap

As setxkbmap is much faster in applying new keyboard maps than xmodmap, I've put setxkbmap into XmodmapFollow. At least the keyboard switching is faster now, despite the bugs of xdotool.

