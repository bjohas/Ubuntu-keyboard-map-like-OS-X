#!/usr/bin/perl
use warnings;
use strict;
use open IO => ':encoding(UTF-8)', ':std';
use utf8;
use feature qw{ say };
use 5.18.2;
use String::ShellQuote;
#$string = shell_quote(@list);
my $home = $ENV{HOME};
(my $date = `date +'%Y-%m-%d_%H.%M.%S'`) =~ s/\n//;
my $help = "";
my $string = "";
my $number = "";
use Getopt::Long;
GetOptions (
    "string=s" => \$string, 
    "help" => \$help, 
    "number=f" => \$number, 
    ) or die("Error in command line arguments\n");

my $keymap;
my $evdevvar;
&setStuff;
my $evdev = "/usr/share/X11/xkb/rules/evdev.xml";
my $us = "/usr/share/X11/xkb/symbols/us";

my $hashyper = 0;
open F,"$us";
while (<F>) {
    if (m/hyperDesktop/) {
	$hashyper = 1;
    };
};
close F;

if ($hashyper) {
    say "Keyboard map us ($us) already has hyperDesktop addition.";
} else {
    say "Adding hyperDesktop to keyboard map us ($us).";
    open F,">>$us";
    print F $keymap;
    close F;
};

$hashyper = 0;
open F,"$evdev";
while (<F>) {
    if (m/hyperDesktop/) {
	$hashyper = 1;
    };
};
close F;

if ($hashyper) {
    say "Evdev already has hyperDesktop addition ($evdev).";
} else {
    say "Adding hyperDesktop to evdev ($evdev).";
    open F,"<$evdev";
    open G,">$evdev.new" or die("Cannot open new evdev. sudo?");
    my $spotter = 0;
    while (<F>) {
	print G $_;
	# <configItem>
	#   <name>us</name>
	#   <!-- Keyboard indicator for English layouts -->
	#   <shortDescription>en</shortDescription>
	#   <description>English (US)</description>
	#   <languageList>
	#     <iso639Id>eng</iso639Id>
	#   </languageList>
	# </configItem>
	# <variantList>
	$spotter++ if m|<name>us</name>|;
	$spotter++ if m|</configItem>| && $spotter==1;
	$spotter++ if m|<variantList>| && $spotter==2;
	#    print G $evdevvar;
	print $spotter , ": ", $_;
	if ($spotter==3) {
	    print G $evdevvar ;
	    $spotter++;
	};
    };
    close G;
    close F;
    say "Moving evdev into place.";
    system("mv",-i,"$evdev","$evdev.old");
    system("mv",-i,"$evdev.new","$evdev");
};

say "Switching keyboard map";
my $map = "us(hyperDesktop)";
system "setxkbmap \"$map\"";


sub setStuff {
    $evdevvar = <<ENDSHERE;
        <variant>
          <configItem>
            <name>hyperDesktop</name>            
            <shortDescription>hD</shortDescription>
            <description>English (hD-US, Hyper-Desktop, current)</description>
            <languageList>
	      <iso639Id>eng</iso639Id>
            </languageList>
          </configItem>
        </variant>
ENDSHERE
    $keymap = <<ENDSHERE;
partial alphanumeric_keys modifier_keys
xkb_symbols "hyperDesktop" {

    include "us(basic)"
    name[Group1]= "enHD (English, US, Hyper-Desktop, v2)";
    key <LSGT> { [     grave,    asciitilde      ]     };
    key <TLDE> { [sterling, EuroSign] };

    replace key <LALT> { [ Control_L, Control_L ] };
    replace key <RALT> { [ Control_R, Control_R ] };
    modifier_map Control { <LALT>, <RALT> };

    replace key <LWIN> { [ Alt_L, Meta_L ] };
    modifier_map Mod1    { <LWIN> };

    key <CAPS> { [ Hyper_L, Hyper_L ] };
    replace key <RCTL> { [ Hyper_R, Hyper_R ] };
    modifier_map Mod3    { <CAPS>, <RCTL> };

    // replace physical <HYPR> key with Super.
    // Laptop keyboard doesn't have <HYPR> but whatever is on HYPR is added to Mod4 below, so has to be Super.    
    replace key <LCTL> { [ Super_L, Super_L ] };
    replace key <HYPR> { [ Super_R, Super_R ] };
    modifier_map Mod4    { <LCTL>, <HYPR> };

    // Best to leave mod2/mod5 alone:
    // mod2        Num_Lock (0x4d)
    // mod5        ISO_Level3_Shift (0x5c),  Mode_switch (0xcb)
    // If you want to use those, you'd have to go into us(basic) and stop them being assigned.	
};
ENDSHERE
};
