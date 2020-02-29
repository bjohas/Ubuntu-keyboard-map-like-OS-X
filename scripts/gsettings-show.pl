#!/usr/bin/perl

print "

This script shows both gsettings and dconf settings.
It seems that gsettings is the more common way of adjusting system settings,
but not all settings are available through gsettings.
dconf settings below start with a slash.

";


@s = split /\n/, `gsettings list-schemas`;
if (!@ARGV) {
    print "gsettings";
    foreach (@s) {
	system "gsettings list-recursively $_";    
    };
    print "dconf";
    my @a = `dconf dump /`;
    foreach (@a) {
	next if !m/\S/;
	if (m/^\[(.*)\]$/) {
	    $prefix = $1;
	} else {
	    s/=/ /;
	    print "/$prefix/$_";
	};
    };
    print "\n\n\n";
} else {
    print "Find (in gsettings only): $ARGV[0]\n";
    foreach (@s) {
	push @a, split /\n/,`gsettings list-recursively $_`;    
    };
    # @a = sort @a;
    foreach (@a) {
	if (m/$ARGV[0]/) {
	    push @b,$_."\n";
	};	
    };
    foreach (@b) {
	$a = $_;
	$_ =~ s/^(\S+) (\S+) (.*?)$/$3\t$2\t($1)/;
	while ($a =~ s/'[^\']+?([^\'\>\<]+)'//) {
	    $x = "$1:";
	    while (length $x < 10) {
		$x .= " ";
	    };
	    $b{$x.$_} = 1;
	};
    };
    print sort keys %b;
    print "\n";
};

sub key {
    if ($_[0] =~ m/\['[^\']+?([^\'\>\<]+)'/) {
	return lc($1);
    };   
};

