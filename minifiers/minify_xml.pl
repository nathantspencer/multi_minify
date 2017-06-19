#!/usr/bin/perl
use strict;
use warnings;
use Term::ANSIColor;

print color('green');
print "$ARGV[0] --> $ARGV[1]\n";
print color('reset');
