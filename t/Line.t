use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Math::Shape::Line' };

# new
ok my $line1 = Math::Shape::Line->new(1, 1, 1, 1), 'constructor';
ok my $line2 = Math::Shape::Line->new(2, 4, 2, 1), 'constructor';
ok my $line3 = Math::Shape::Line->new(2, 4, 2, 1), 'constructor';

# equivalent
is $line1->is_equivalent($line2), 0;
is $line2->is_equivalent($line1), 0;
is $line2->is_equivalent($line3), 0;

# collides
is $line1->collides($line2), 1;
is $line2->collides($line1), 1;
is $line2->collides($line3), 1;

ok my $line4 = Math::Shape::Line->new(3, 5, 5,-1);
ok my $line5 = Math::Shape::Line->new(3, 5, 5, 2);
ok my $line6 = Math::Shape::Line->new(3, 2, 5, 2);
ok my $line7 = Math::Shape::Line->new(8, 4, 5, -1);

is $line4->collides($line5), 1;
is $line4->collides($line6), 1;
is $line5->collides($line6), 1; # error ?
is $line4->collides($line7), 1;

done_testing();

