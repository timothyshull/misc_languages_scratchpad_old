use strict;
use warnings;

sub _dmsetup_remove
{
    my $dmsetup = system_bt( "/sbin/dmsetup ls" );
    my (@part_array) = ($dmsetup =~ m#(mpath[a-z]*p\d+)#sg);

    my $part;
    foreach $part (@part_array)
    {
        _system( "/sbin/dmsetup remove $part" );
    }
}

