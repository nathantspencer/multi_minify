#!/usr/bin/perl
use strict;
use warnings;
use Term::ANSIColor;

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


#============================== MAIN BEGINS HERE ==============================#

open(my $fh, '<:encoding(UTF-8)', $ARGV[0])
  or die printError("file $ARGV[0] could not be opened.");

my @lines;
my $quoteCount = 0;

while (my $line = <$fh>)
{
  chomp $line;

  my @chars = split //, $line;
  my $iterator = 0;
  while ($iterator < scalar(@chars))
  {
    if ($chars[$iterator] eq '"')
    {
      $quoteCount++;
      $iterator++;
    }
    elsif ($chars[$iterator] eq ' ' && $quoteCount % 2 == 0)
    {
      splice @chars, $iterator, 1;
    }
    elsif ($chars[$iterator] eq '\t' && $quoteCount % 2 == 0)
    {
      splice @chars, $iterator, 1;
    }
    else
    {
      $iterator++;
    }
  }
  $line = join('', @chars);
  push @lines, $line;
}

close $fh;

open($fh, '>', $ARGV[1]) or die printError("file $ARGV[1] could not be written");

my $line;
foreach $line (@lines)
{
  print $fh $line;
}
close $fh;

print color('green');
print "$ARGV[0] --> $ARGV[1]\n";
print color('reset');
