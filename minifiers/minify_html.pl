#!/usr/bin/perl
use strict;
use warnings;
use Term::ANSIColor;
use multi_minify;

open(my $fh, '<:encoding(UTF-8)', $ARGV[0])
  or die multi_minify::printError("file $ARGV[0] could not be opened.");

my @lines;

while (my $line = <$fh>)
{
    chomp $line;

    # remove comments
    $line =~ s/<!--.*-->//g;
    $line =~ s/^\s+//g;
    $line =~ s/\s+$//g;
    $line =~ s/>\s+</></g;
    push @lines, $line;
}

close $fh;

open($fh, '>', $ARGV[1]) or die multi_minify::printError("file $ARGV[1] could not be written");

my $line;
foreach $line (@lines)
{
  print $fh $line;
}
close $fh;

print color('green');
print "$ARGV[0] --> $ARGV[1]\n";
print color('reset');
