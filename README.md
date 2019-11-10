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
If you then bind the hyper-a/e/d/k etc to beginning/end of line, delete char, cut to end of line (e.g. using autokey) you have an OS-X-desktop like binding.

(Of course you can reorder the keys as you like - in OS X I've had the ctrl/caps key swapped forever.)

## Setting up the Ubuntu-Terminal shortcuts so that they work like OS X

However, this now leaves the keyboard bindings for the Ubuntu-Terminal (esp. emacs) quite different from muscle memory.

to be continued
