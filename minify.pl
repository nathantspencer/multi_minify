#!/usr/bin/perl
use strict;
use warnings;
use Term::ANSIColor;

if(@ARGV != 2)
{
  my $number_of_arguments = @ARGV;

  print color('bold red');
  print "\nERROR: ";
  print color('reset');
  print color('red');
  print "expected 2 arguments, had $number_of_arguments.\n";
  print color('reset');

  print "\nTo minify a single file, use this script as shown below:\n";
  print "\$ perl minify.pl input.json output.json\n";

  print "\nAlternatively, to minify a batch of files, try this:\n";
  print "\$ perl minify.pl /input/directory/ /output/directory/\n\n";
}
else
{

}
print $ARGV[0];
