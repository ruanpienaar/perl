#!/usr/bin/perl -w
use strict;
my $pie = 3.141592654;
print "Enter the radius: \n";
my $radius = <STDIN>;
my $circlecircumference;

if($radius gt 0){
  $circlecircumference = 2 * $pie * $radius ;
}else{
  $circlecircumference = 0;
}

print $circlecircumference."\n";
