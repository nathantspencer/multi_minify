#!/usr/bin/perl
use strict;
use warnings;
use Term::ANSIColor;

#================================= SUBROUTINES ================================#

sub printError
{
  print color('bold red');
  print "ERROR: ";
  print color('reset');

  print color('red');
  if(@_ > 0)
  {
    print $_[0];
  }
  else
  {
    print("unknown error occurred.")
  }
  print color('reset');
  print "\n";

  return;
}


#============================== MAIN BEGINS HERE ==============================#

print "\n";

if(@ARGV != 2)
{
  my $number_of_arguments = @ARGV;

  printError("minify.pl expected 2 arguments, had $number_of_arguments.");

  print "\nTo minify a single file, use this script as shown below:\n";
  print "\$ perl minify.pl input.json output.json\n";

  print "\nAlternatively, to minify a batch of files, try this:\n";
  print "\$ perl minify.pl /input/directory/ /output/directory/\n";
}
else
{
  if(-d $ARGV[0])
  {
    print "Starting multi_minify in batch mode...\n";
    if(! -d $ARGV[1])
    {
      printError("input argument is batch, but output argument is single file.")
    }
    else
    {
      # BEGIN BATCH MODE
    }
  }
  else
  {
    print "Starting multi_minify in single file mode...\n";
    if(-d $ARGV[1])
    {
      printError("input argument is single file, but output argument is directory.")
    }
  }
}

print "\n"
