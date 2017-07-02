#!/usr/bin/perl

use strict;
use warnings;

my ($opt, undef)    = @ARGV;
my @cpuInfo         = `cat /proc/cpuinfo`;
my %cpuInfo =    (
                    "0002"    => ["Model B Rev 1", "256"],
                    "0003"    => ["Model B Rev 1", "256"],
                    "0004"    => ["Model B Rev 2", "256"],
                    "0005"    => ["Model B Rev 2", "256"],
                    "0006"    => ["Model B Rev 2", "256"],
                    "0007"    => ["Model A", "256"],
                    "0008"    => ["Model A", "256"],
                    "0009"    => ["Model A", "256"],
                    "000d"    => ["Model B Rev 2", "512"],
                    "000e"    => ["Model B Rev 2", "512"],
                    "000f"    => ["Model B Rev 2", "512"],
                    "0010"    => ["Model B+", "512"],
                    "0013"    => ["Model B+", "512"],
                    "0012"    => ["Model A+", "256"],
                    "0015"    => ["Model A+", "256/512"],
                    "a01041"  => ["Pi 2 Model B v1.1", "1Gb"],
                    "a21041"  => ["Pi 2 Model B v1.1", "1Gb"],
                    "a22042"  => ["Pi 2 Model B v1.2", "1Gb"],
                    "a02082"  => ["Pi 3 Model B", "1Gb"],
                    "a22082"  => ["Pi 3 Model B", "1Gb"],
                    "900092"  => ["PiZero v1.2", "512"],
                    "900093"  => ["PiZero v1.3", "512"],
                    "9000c1"  => ["PiZero W", "512"]
                );

sub GetCpuInfo() {
    my $revVal = "";

    foreach ( @cpuInfo ) {
        if ( /Revision/ ) {
            (undef, $revVal) = split(/:/);
            $revVal =~ s/^\s+|\s+$//g;
        }
    }

    if ( $revVal ne "" ) {
        &PrintHead();
        &PrintDetails($revVal);
    } else {
        print "Hmmm, are you sure this is a Raspberry Pi?\n";
    }
}

sub ShowAll() {
    my $cpu;

    &PrintHead();

    foreach $cpu( sort { @{$cpuInfo{$b}} <=> @{$cpuInfo{$a}} || $a cmp $b } keys %cpuInfo) {
        &PrintDetails($cpu);
    }
}

sub PrintHead() {
    print "=" x 32, "\n";
    printf ("%8s %10s %12s \n", "Revision", "Model", "Memory");
    print "=" x 32, "\n";
}

sub PrintDetails() {
    my ($revVal) = @_;

    printf ("%-8s %-18s %-8s \n", $revVal, $cpuInfo{$revVal}[0], $cpuInfo{$revVal}[1]);
}

sub PiRevHelp() {
    print "Help - The Beatles\n";
    print "Lennon/Mccartney - Parlophone, Capitol Records\n";
    print "Released 1965, B Side - 'I'm Down'\n";
}

$opt = "" unless $opt; 

if ( $opt eq "" ) {
    &GetCpuInfo();
} elsif ( $opt eq "-all" ) {
    &ShowAll(); 
} elsif ( $opt eq "-help" ) {
    &PiRevHelp();
} else {
    print "Command not recognised, try - 'rpcpu -help'\n";
}

exit;
