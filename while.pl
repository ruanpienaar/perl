#!/usr/bin/perl -w

use strict;

my $count = 0;

while ( $count < 10 ){
  print "Counting.....\n";
  $count++;
}

if( defined($count) ){
  print "O, and \$count was defined ;) \n";
}

$count = undef;
if( !defined($count) ){
  print "Well, i just made it undef right in front of your eyes !\n";
}