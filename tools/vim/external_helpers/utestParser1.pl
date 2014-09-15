#/usr/bin/perl

use strict;
use warnings;


sub main(@);

#print "*** $#ARGV : ".join(", ", @ARGV)."\n";
exit( main(@ARGV) ); 

sub main(@) {
    my ($logFile) = @_;
	my $label = undef;
	while(<STDIN>) {
		unless( defined( $label ) ) {
			if( /label = "(TPF-\d+)"/) { $label = $1; }
		}
		print $_;
	}
	unless( defined( $label ) || defined($logFile ) ) { return 0; }
#print "---$label ---\n";

	open LOG, "<$logFile" or die $!;
	while (<LOG>) {
		if( /$label:.*current value \(([^()]*)\)/ ) {
			my $value=$1*1;
			print "  expectedRiskValues = { PV=$value  fxDelta=NaN fxGamma=NaN fxTotalVega=NaN }\n";
			last;
		}
	}
	close LOG;
	return 0;
}
