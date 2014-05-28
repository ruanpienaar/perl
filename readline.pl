#!/usr/bin/perl -w

$line = <STDIN>;

if($line ne "\n"){
  print "Your input was : ".$line."\n";
}else {
  print "Enter more than an empty string :) \n"
}

