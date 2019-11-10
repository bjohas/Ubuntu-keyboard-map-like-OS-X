#!/usr/bin/perl

@s = split /\n/, `gsettings list-schemas`;

foreach (@s) {
    system "gsettings list-recursively $_";    
};
