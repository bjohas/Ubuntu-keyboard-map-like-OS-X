#!/usr/bin/perl

$sleeptime = 0.1;
$tcolor = "#CCCCAA";
$dcolor = "#003A4C";

$res = "$ENV{HOME}/bin/res";

$verbose = $ARGV[0];
$switcher = "setxkbmap";
$oldwpid = "";

while (1==1) {
    $oldwpid = "";
    &updateStatus();
    # 'killprocess' is a custom script that kills, well, processes.
    system "killprocess --all xdotool";
    system "killprocess --all wmctrl";
    open F,"xdotool search --class '.' behave %@ focus getwindowpid |";
    $prevmode = "";
    while (<F>) {
	$i++;
	s/\n//;
	# Display some of the xdotool errors, but suppress one frequently occuring one:
	if ($_ !~ m/^\d+$/) {
	    if ($_ eq "Unexpected event: 34") {
		print "+";
	    } else {
		print "ERROR: $_\n";
	    };
	} else {
	    # See whether the wpid has changed.
	    if ($_ ne $oldwpid) {
		&updateStatus();
	    } else {
		# Windowpid hasn't changed - do nothing
	    };
	};
	$prevmode = $currentmode;
    };
    # xdotool existed
    ($date = `date`) =~ s/\n//;    
    &dashToDock("#AA0000");
    print "
-------------------------------------------------
xdotool exited on $date
-------------------------------------------------
Restarting shortly.
";
    # Immediate restarting wasn't a good idea, so 
    for ($x=0;$x<5;$x++) {
	&dashToDock("#AA0000");
	sleep 1;
	&dashToDock("#0000AA");
	sleep 1;
    };
    &dashToDock("#AA0000");
    print "Restarting ...\n";
    # Next step is to kill potentially still running subprocesses, and then go again. See above.
}; # 1==1

sub dashToDock() {
    system "gsettings set org.gnome.shell.extensions.dash-to-dock background-color \"@_[0]\"";
    return;
};

sub updateStatus() {
    print "\n\n-------- ",`date`;
    print "\n";
    if ($oldwpid eq "") {
	print "First run.\n";
    };
    print "getwindowpid -> $_\n" if $verbose;
    print "WindowPid changed: $_\n" if $verbose;
    print "-- getwindowfocus:\n" if $verbose;
    ($f = `xdotool getwindowfocus`) =~s/\n//;
    print "-- getwindowfocus = $f\n" if $verbose;
    my $hex = sprintf("0x%X", $f);
    $hex = lc($hex);
    $hex =~ s/0x//;
    print "-- getwindowfocus = $f = $hex\n" if $verbose;
    print "--wmctrl:\n" if $verbose;
    $string = `wmctrl -lGpx | grep '$hex'`;
    print "$string\n" if $verbose;
    # Now see what keyboard map to apply
    if ($string =~ m/gnome\-terminal\-server\.Gnome\-terminal|emacs\.Emacs/i) {
	print "Type: Terminal\n" if $verbose;
	$currentmode = "t";
    } else {
	print "Type: Desktop\n" if $verbose;
	$currentmode = "d";
    };
    if ($prevmode ne $currentmode || $prevmode eq "") {
	if ($currentmode eq "t") {
	    # We've newly arrived in 'terminal mode'
	    print "\nSwitch to terminal\n" if $verbose;
	    sleep $sleeptime;
	    if ($switcher eq "xmodmap") {
		print "xmodmap\n" if $verbose;
		system "xmodmap $res/Xmodmap_terminal";
	    } else {
		print "setxkbmap\n" if $verbose;
		# For this to work, the keyboard map needs to be in /usr/share/X11/xkb/symbols/			
		system "setxkbmap enT";
		# Alternatively you can do put the map elsewhere (i.e. into $res) and then do this:
		# system "xkbcomp $res/enT $ENV{DISPLAY}";
	    };
	    print "gsetting\n" if $verbose;
	    # There are a few keyboard settings we also want to adjust:
	    system "gsettings set org.gnome.desktop.wm.keybindings switch-windows \"['<Hyper>Tab']\"";
	    system "gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward \"['<Hyper><Shift>Tab']\"";
	    # As the switching process is not very reliable, colour the dock to give user feedback:
	    &dashToDock($tcolor);
	} else {
	    # We've newly arrived in 'desktop mode'
	    print "\nSwitch to desktop\n" if $verbose;
	    sleep $sleeptime;
	    if ($switcher eq "xmodmap") {
		print "xmodmap\n" if $verbose;
		system "xmodmap $res/Xmodmap_desktop";
	    } else {
		print "setxkbmap\n" if $verbose;
		system "setxkbmap enD";
		# system "xkbcomp $res/enD $ENV{DISPLAY}";
	    };
	    print "gsetting\n" if $verbose;
	    # There are a few keyboard settings we also want to adjust back:
	    system "gsettings set org.gnome.desktop.wm.keybindings switch-windows \"['<Control>Tab']\"";
	    system "gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward \"['<Control><Shift>Tab']\"";
	    # (Seems you can use <Primary> instead of <Control> too.)
	    # As the switching process is not very reliable, colour the dock to give user feedback:
	    &dashToDock($dcolor);
	};
    }
    $oldwpid = $_;
    # We're also using autokey to provide actions for Hyper-a/e/d/k etc (emulating Ctrl-a/e/d/k etc on the desktop).
    # As autokey sometimes misbehaves, let's check autokey occasionally.
    $autokey = `ps eaxu | grep autokey-gtk | grep -v grep`;
    print "autokey\n" if $verbose;
    if ($autokey !~ m/autokey/s) {
	# Warn if there's no autokey and colour the dock accordingly.
	print "\nWarning - no autokey\n";		    
	&dashToDock("#AA0033");
    };
    # Also using copyq for clipboard history, which occasionally crashes. So check it.
    $copyq = `ps eaxu | grep copyq | grep -v grep`;
    print "copyq\n" if $verbose;
    if ($copyq !~ m/copyq/s) {
	# Warn if there's no copyq, restart, and colour the dock accordingly.
	print "\nWarning - no copyq. Restarting copyq.\n";
	system "copyq &";
	&dashToDock("#AA0055");
    };
};
