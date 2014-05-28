#!/usr/bin/perl -w
use strict;

print "Enter string to repeat:\n";
my $input = <STDIN>;
print "Enter the amount of repetitions:\n";
my $times = <STDIN>;

print $input x $times;