#!/usr/bin/perl

$verbose = $ARGV[0];

# With the use of the 'hyper key' modification to Gnome Terminal, the keyboard map switching is no longer needed and these are obsolete:
#&keybindings("switch-applications","Hyper;Control","Tab");
#&keybindings("switch-group","Hyper;Control","grave");
# and replaced by this:
&keybindings("switch-applications","Control","Tab");
&keybindings("switch-group","Control","grave");

&keybindings("switch-windows","Alt","Tab");
&keybindings("cycle-windows","Super","Tab");

&keybindings("cycle-group","Super","grave");
&keybindings("switch-panels","Alt","grave");

&gsettings("org.gnome.mutter","overlay-key",'');
&gsettings("org.gnome.shell.keybindings","toggle-message-tray","['<Super>m']");

# org.gnome.shell.keybindings toggle-application-view ['<Super>a']
&gsettings("org.gnome.shell.keybindings","toggle-application-view","['<Super>a','<Super>space','<Control>space']");

# org.gnome.shell.keybindings toggle-overview ['<Super>s']

&gsettings("org.gnome.shell.keybindings","toggle-overview","['<Super>s','<Shift><Super>space']");

&gsettings("org.gnome.desktop.wm.keybindings","switch-input-source","['<Super>i']");
&gsettings("org.gnome.desktop.wm.keybindings","switch-input-source-backward","['<Shift><Super>i']");
# org.gnome.desktop.wm.keybindings close ['<Super>w']

&gsettings("org.gnome.settings-daemon.plugins.media-keys","logout","['<Super>Delete']");

&gsettings("org.freedesktop.ibus.panel.emoji","hotkey","['<Control><Alt><Shift>e']");
&gsettings("org.freedesktop.ibus.panel.emoji","unicode-hotkey","['<Control><Shift>u']");

&gsettings("org.gnome.desktop.wm.keybindings","minimize","['<Super>h','<ctrl>m']");

sub gsettings() {
    system("gsettings","set",$_[0],$_[1],$_[2]);
    if ($verbose) {
	print("gsettings set $_[0] $_[1] \"$_[2]\"\n");
    };
};

sub keybindings() {
    # typically keybindings("switch-windows","Hyper;Control","Tab");
    (my $a, my $b, my $c) = @_;
    if ($a) {
	my @b = split /;/,$b;
	my @x;
	my @y;
	foreach (@b) {
	    my $combo = "";
	    my @c = split /\+/,$_;
	    foreach (@c) {
		$combo .= "<$_>";
	    };
	    push @x, "'$combo$c'";
	    push @y, "'<shift>$combo$c'";	    
	};
	my $string = "[".join(",",@x) ."]";
	my $stringb = "[".join(",",@y) ."]";
	&gsettings("org.gnome.desktop.wm.keybindings",$a,$string);
	&gsettings("org.gnome.desktop.wm.keybindings","$a-backward",$stringb);
	#print "gsettings set org.gnome.desktop.wm.keybindings $a \"$string\"\n";
	#print "gsettings set org.gnome.desktop.wm.keybindings $a-backward \"$stringb\"\n";
    };
};
