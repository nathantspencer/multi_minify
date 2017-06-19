#!/usr/bin/perl
package multi_minify;

use strict;
use warnings;
use Exporter;
use Term::ANSIColor;
use IPC::System::Simple qw(system capture);
use File::Basename;
use v5.10;

no warnings 'experimental::smartmatch';

use vars '$VERSION';
$VERSION = '1.0.1';

our @ISA= qw( Exporter );
our @EXPORT_OK = qw( printError );
our @EXPORT = qw( printError );


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
  my @exts = qw(.json .xml .svg .html .htm .dae);
  my $file = $_[0];
  my ($name, $dir, $ext) = fileparse($file, @exts);

  for ($ext)
  {
      when ('.json')
      {
        system($^X, "minifiers/minify_json.pl", $_[0], $_[1]);
      }
      when ('.xml' || '.svg' || '.html' || '.htm' || '.dae')
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
