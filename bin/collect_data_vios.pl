#!/usr/bin/env bash

use strict;
use warnings;
use Data::Dumper;
use Getopt::Long;

Getopt::Long::Configure("no_ignore_case");
Getopt::Long::Configure("bundling");

our $Version = "2018062901";
our $Separator = '|  |';
our $Verbose = 0;

#Creating Debug file name
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime(time);
my $now = sprintf("%04d%02d%02d_%02d%02d%02d", $year+1900, $mon+1, $mday, $hour, $min, $sec);

our $LparName = `uname -n`;
chomp $LparName;

my $FileName = "/tmp/${LparName}.${now}.lparinfo.txt";
my $FileNameLatest = "/tmp/${LparName}.latest.lparinfo.txt";


sub WriteToFileVersion {
    open(my $fh, '>>', $FileName) or die "Couldn't open file '$FileName' $!";
    print $fh "ScriptVersion${Separator}${Version}";
    close $fh;
}

sub WriteToFile {
    my $Command = shift;

    open(my $fh, '>>', $FileName) or die "Couldn't open file '$FileName' $!";

    if ($Verbose > 0) {
        print STDERR "Calling command $Command \n";
    } else {
        print STDERR ".";
    }
    close $fh;
}

sub CollectDataAndExit {
    print STDERR "I will collect debug data and exit...\n\n" if ($Verbose > 0);
    print STDERR $LparName."  ";

    WriteToFileVersion();
    WriteToFile 'uname -n';
    WriteToFile 'date -u';
    WriteToFile 'date +"%s"';
    WriteToFile 'lsdev | egrep "ent|fcs"';
    WriteToFile 'lscfg | egrep " ent|fcs"';

    my $Devices = `lsdev | grep ent | awk '{ print $1}`;
    my @Devices = split $Devices, "\n";
    foreach my $Device (@Devices) {
        WriteToFile("lsattr -O -El $Device");
        WriteToFile("lsattr -O -Pl $Device");
        WriteToFile("entstat -d $Device");
    }

    my $Devices = `lsdev | grep fcs | awk '{ print $1}`;
    my @Devices = split $Devices, "\n";
    foreach my $Device (@Devices) {
        WriteToFile("lsattr -O -El $Device");
        WriteToFile("lsattr -O -Pl $Device");
        WriteToFile("fcstat -d $Device");
    }

    my $Devices = `lsdev | grep fscsi | awk '{ print $1}`;
    my @Devices = split $Devices, "\n";
    foreach my $Device (@Devices) {
        WriteToFile("lsattr -O -El $Device");
        WriteToFile("lsattr -O -Pl $Device");
        WriteToFile("lsdev -l $Device -F parent");
    }

    WriteToFile('lspath');

    WriteToFile 'lsvg rootvg';
    WriteToFile 'lsvg -p rootvg';
    WriteToFile 'lsvg -l rootvg';
    WriteToFile 'getconf BOOT_DEVICE';

    #if is it VIOS
    WriteToFile '/usr/ios/cli/ioscli lsmap -all -net';
    WriteToFile '/usr/ios/cli/ioscli lsmap -all -npiv';
    WriteToFile '/usr/ios/cli/ioscli lsmap -all';

    #
    WriteToFile 'ps -ef';
    WriteToFile 'errpt';
    WriteToFile '';
    WriteToFile 'echo "---end---"';

    print STDERR "All data have been written to: ${FileName} \n" if ($Verbose > 0);

    print STDERR "Creating symbolic link ${FileNameLatest}" if ($Verbose > 0);
    `ln -f -s ${FileName} ${FileNameLatest}`;

    if ($Verbose > 0) {
        print STDERR "\nDone...\n\n";
    } else {
        print STDERR "Done ";
    };

}

CollectDataAndExit;

exit 0;