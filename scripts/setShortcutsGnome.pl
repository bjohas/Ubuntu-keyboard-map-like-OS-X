#!/usr/bin/perl

$verbose = $ARGV[0];

&keybindings("switch-applications","Hyper;Control","Tab");
&keybindings("switch-group","Hyper;Control","grave");

&keybindings("switch-windows","Alt","Tab");
&keybindings("cycle-windows","Super","Tab");

&keybindings("cycle-group","Super","grave");
&keybindings("switch-panels","Alt","grave");

&gsettings("org.gnome.mutter","overlay-key",'');
&gsettings("org.gnome.shell.keybindings","toggle-message-tray","['<Super>m']");

# org.gnome.shell.keybindings toggle-application-view ['<Super>a']
&gsettings("org.gnome.shell.keybindings","toggle-application-view","['<Super>a','<Hyper>space']");

# org.gnome.shell.keybindings toggle-overview ['<Super>s']

&gsettings("org.gnome.shell.keybindings","toggle-overview","['<Super>s','<Shift><Hyper>space']");
# org.gnome.desktop.wm.keybindings switch-input-source ['<Super>space']
# org.gnome.desktop.wm.keybindings switch-input-source-backward ['<Shift><Super>space']
# org.gnome.desktop.wm.keybindings close ['<Super>w']


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


