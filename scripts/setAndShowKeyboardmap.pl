#!/usr/bin/perl

# This script assumes that you have files called Xmodmap_something in ~/bin/res/
my @a = split /\n/, `ls -1 ~/bin/res/Xmod*`;
my %f;
my $str;
foreach (@a) {
    next if m/\~/;
    if (m/([A-Za-z1-90]+)$/) {
	$str .= "$1 -> $_\n";
	$f{$1} = $_;
    } else {
	print "unrecognised: $_\n";
    };
};

if (!@ARGV || $help) {
    print("Need arguments

$0 

Set xkbmap or xmodmap 

The following xmodmaps are available:
$str

Use a keyboard map from /usr/share/X11/xkb/symbols:
	  ");
    my $y = `ls /usr/share/X11/xkb/symbols`;
    $y =~ s/\s+/ /sg;
    print $y;
    print "\n";
    exit;
};

sub showLabel() {
    # You will have to enter the labels used on your keyboard here.
    # The labels below are used on some Lenovo Yoga laptops.
    my %keyboardLabels = qw{66 CapsLk
			37 Ctrl/L
			133 Win
			64 Alt
			108 AltGr
			105 Ctrl/R};
    if ($keyboardLabels{$_[0]}) {
	return "=".$keyboardLabels{$_[0]};
    } else {
	return "=?";
    };
};
foreach (@ARGV) {
    print "ARGUMENT: $_\n";
    if ($f{$_}) {	
	print "Xmodmap: $_ -> $f{$_}\n";
	if (m/Xmodmap/) {
	    system "xmodmap '$f{$_}'";
	};
    } else {
	print "setxkbdmap: $_\n";
	system "setxkbmap $_";
    };
    print "Mapping is:\n";
    my $x = `xmodmap -pm`;
    $x =~ s/0x(\w+)/"0x$1=".hex($1).&showLabel(hex($1))/eg;
    print $x;
};

exit();
