#!/usr/bin/perl
use strict;
use warnings;
use multi_minify;

print "\n";

if(@ARGV != 2)
{
  my $number_of_arguments = @ARGV;

  multi_minify::printError("minify.pl expected 2 arguments, had $number_of_arguments.");

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
      multi_minify::printError("input argument is batch, but output argument is not a directory")
    }
    else
    {
      multi_minify::batch($ARGV[0], $ARGV[1]);
    }
  }
  else
  {
    print "Starting multi_minify in single file mode...\n";
    if(-d $ARGV[1])
    {
      multi_minify::printError("input argument not a directory, but output argument is directory.")
    }
    else
    {
      multi_minify::minify($ARGV[0], $ARGV[1]);
    }
  }
}

print "\n"
