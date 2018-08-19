use strict; use warnings;

BEGIN { -f 'META.yml' or ( print "1..0 # SKIP running in a VCS checkout\n" ), exit }

use Pod::Readme::Brief;

sub fh { open my $fh, '<', $_[0] or die "Could not open $_[0] to read: $!\n"; $fh }

my @src = readline fh $INC{'Pod/Readme/Brief.pm'};

my $expected = do { local $/; readline fh 'README' };

my $got = Pod::Readme::Brief->new( @src )->render( installer => 'eumm' );

my $diag = '';
my $ok = $expected eq $got ? 'ok' : do { ( $diag = $got ) =~ s/^/# /mg; 'not ok' };

print <<".";
1..1
$ok 1 - re-rendering own README yields identical results
$diag
.
