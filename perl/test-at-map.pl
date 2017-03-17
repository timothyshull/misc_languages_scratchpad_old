use strict;
use warnings;

#$aref = \@array;
#$href = \%hash;
#$sref = \$scalar;

#my %map = {
#    "test1" => 1,
#    "test2" => 2
#};

my @map = (1, 2, 3);

my $test_map = \@map;

my $elt;
foreach $elt (@$test_map)
{
    print "$elt\n";
}
