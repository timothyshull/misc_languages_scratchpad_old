use strict;
use warnings;


my $test_var = 10;

$test_var //= 2;

print "$test_var\n";

my $test_var2;

$test_var2 //= 2;

print "$test_var2\n";