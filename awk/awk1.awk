#!/usr/local/bin/awk -f
{
   a=$0;
   print "This is a test: a is " a;
   b=$1;
   print "This is \$1: " b;
}