#!/usr/bin/perl -w

print "Hello\n";
print "1fred" + 2 ."\n";

$var = "This is my first vaR !\n";
print $var;


if($var ne 1){
  print "MMM\n";
}

if($emptyvar){
  print "This will never print \n";
}else{
  print "This will always print because $emptyvar is undef, and undef is false. and also raises a warning hahahaha\n";
}


if(2){
  print "In perl any number bigger than 0 is TRUE, that is cool\n";
}
