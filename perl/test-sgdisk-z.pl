use strict;
use warnings;

sub _sgdisk_z
{
    my (%p) = @_;

    my $metadata = $p{'metadata'};

    my $drive;

    foreach $drive (sort keys(%$_fdisk_drives))
    {
        next if ($drive =~ m#/dev/mapper# && $drive !~ m#mpath#);
        next if ($drive =~ m#/dev/mapper# && $drive =~ m#p[0-9]+$#);
        next if ("/dev/$metadata->{'system_part'}" eq $drive);
        _system( "dd if=/dev/zero of=$drive bs=1M count=16" );
        _system( "/usr/sbin/sgdisk -Z $drive" );
        _system( "/usr/sbin/sgdisk -Z $drive" );
    }
}