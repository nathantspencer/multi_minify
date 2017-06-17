#!/usr/bin/perl
use strict;
use warnings;
use Term::ANSIColor;

sub printError
{
  print color('bold red');
  print "\nERROR: ";
  print color('reset');

  print color('red');
  if(@_ > 0)
  {
    print $_[0];
  }
  else
  {
    print("unknown error occurred.\n")
  }
  print color('reset');

  return;
}

if(@ARGV != 2)
{
  my $number_of_arguments = @ARGV;

  printError("minify.pl expected 2 arguments, had $number_of_arguments.\n");

  print "\nTo minify a single file, use this script as shown below:\n";
  print "\$ perl minify.pl input.json output.json\n";

  print "\nAlternatively, to minify a batch of files, try this:\n";
  print "\$ perl minify.pl /input/directory/ /output/directory/\n\n";
}
else
{

}
print $ARGV[0];
