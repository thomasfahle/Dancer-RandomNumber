use Test::More tests => 7;
use strict;
use warnings;

diag("Load Modules");

my @subs = qw/random_number/;
use_ok( 'RandomNumber::Generator', @subs );
foreach my $sub (@subs) {
    can_ok( __PACKAGE__, $sub );
}

diag("Random in Range");
my $min    = 100;
my $max    = 200;
my $random = random_number( $min, $max );
ok(
    ( $random >= $min and $random <= $max ),
    "Random $random in range $min .. $max."
);

diag("Test Swapping if \$min > \$max");
$min    = 500;
$max    = 200;
$random = random_number( $min, $max );
ok(
    ( $random >= $max and $random <= $min ),
    "Random $random in swapped range $min .. $max."
);

diag("Negative Ints");
$min    = -500;
$max    = 2;
$random = random_number( $min, $max );
ok(
    ( $random >= $min and $random <= $max ),
    "Random $random in negative range $min .. $max."
);

diag("Random out of Range");
$min    = -1234567890;
$max    = 1234567890;
$random = random_number( $min, $max );
ok( $random =~ m/Fehler/, "Ok Bereichsgrenzen abgefangen." );

diag("Zero Range");
$min    = 0;
$max    = 0;
$random = random_number( $min, $max );
ok( $random == 0, "Ok Null Bereich." );

