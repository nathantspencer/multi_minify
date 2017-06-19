#!/usr/bin/perl
use strict;
use warnings;
use v5.10;

use Term::ANSIColor;
use File::Basename;
use IPC::System::Simple qw(system capture);

no warnings 'experimental::smartmatch';

#================================= SUBROUTINES ================================#

# params: string error message
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
    print("subroutine printError expected an arugment but had none.")
  }
  print color('reset');
  print "\n";

  return;
}


# params: string input dir, string output dir
sub batch
{
  my $number_of_arguments = @_;

  if(@_ > 1)
  {
    opendir my $input_dir, $_[0] or die printError("input directory $_[0] could not be opened.\n");
    my @files = readdir $input_dir;
    closedir $input_dir;

    my $file;
    foreach $file (@files)
    {
      my @exts = qw(.json .xml);
      my ($name, $dir, $ext) = fileparse($file, @exts);

      if(length($name) >= 4 && substr($name, 0, 4) eq 'min_')
      {
        next;
      }

      if($name eq '.' || $name eq '..' || $name eq '.DS_Store')
      {
        next;
      }

      my $input = $_[0] . $file;
      my $output = $_[1] . 'min_' . $file;
      minify($input, $output);
    }
  }
  else
  {
    printError("subroutine batch expected 2 arguments, had $number_of_arguments.");
  }

  return;
}


# params: str input file, str output file
sub minify
{
  my @exts = qw(.json .xml);
  my $file = $_[0];
  my ($name, $dir, $ext) = fileparse($file, @exts);

  for ($ext)
  {
      when ('.json')
      {
        system($^X, "minifiers/minify_json.pl", $_[0], $_[1]);
      }
      when ('.xml')
      {
        system($^X, "minifiers/minify_xml.pl", $_[0], $_[1]);
      }
      default
      {
        print color('yellow');
        print "$file --> unsupported file type\n";
        print color('reset');
      }
  }

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
      printError("input argument is batch, but output argument is not a directory")
    }
    else
    {
      batch($ARGV[0], $ARGV[1]);
    }
  }
  else
  {
    print "Starting multi_minify in single file mode...\n";
    if(-d $ARGV[1])
    {
      printError("input argument not a directory, but output argument is directory.")
    }
    else
    {
      minify($ARGV[0], $ARGV[1]);
    }
  }
}

print "\n"
