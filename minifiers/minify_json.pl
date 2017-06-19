#!/usr/bin/perl
use strict;
use warnings;
use Term::ANSIColor;
use multi_minify;

open(my $fh, '<:encoding(UTF-8)', $ARGV[0])
  or die multi_minify::printError("file $ARGV[0] could not be opened.");

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
