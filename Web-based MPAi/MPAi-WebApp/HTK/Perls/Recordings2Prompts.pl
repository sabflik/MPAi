#!/usr/bin/perl
use strict;
use File::Basename;
use warnings;

die "Usage: $0 <input dir> <extion> <output dir>\n" unless @ARGV == 3;
my ($InputDir, $Ext, $OutputDir) = @ARGV;

my $pmpt = "Prompts.pmpt";
#print $OutputDir.$script."\n";

open(PMPT, '>', $OutputDir.$pmpt) or die "can't open file script.scp:$!";

if(-d $InputDir) {
    opendir(DH, "$InputDir") or die "Can't open: $!\n" ;
    #load all the files in $InputDir which have suffix "wav"
    my @list = grep {/$Ext$/ && -f "$InputDir/$_" } readdir(DH);
    closedir(DH);
    chdir($InputDir) or die "Can't cd dir: $!\n" ;
    foreach my $file(@list)
    {
        AnalyzeFileName($InputDir."\\".$file);
    }
} 
elsif(-f $InputDir)
{
    AnalyzeFileName($InputDir);
}

sub AnalyzeFileName
{
    my ($fullname) = @_;
    if(-f $fullname){
        my($name,$path,$suffix) = fileparse($fullname, ($Ext));
        if ($Ext eq ".wav" || $Ext eq ".WAV"){
            my @parts=split(/-/,$name);
            if(@parts == 4){
                print PMPT "$name"." "."$parts[2]\n";
            }
			else{
			    print "Wrong name fromat!\n";
			}
        }
    }
}

