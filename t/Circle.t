use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Math::Shape::Circle' };

# new
ok my $circle1 = Math::Shape::Circle->new(1, 1, 54), 'constructor';
ok my $circle2 = Math::Shape::Circle->new(1, 1, 10), 'constructor';
ok my $circle3 = Math::Shape::Circle->new(1, 54, 20), 'constructor';
ok my $circle4 = Math::Shape::Circle->new(60, 100, 5), 'constructor';

# collides
is $circle1->collides($circle2), 1;
is $circle1->collides($circle3), 1;
is $circle1->collides($circle4), 0;
is $circle2->collides($circle3), 1;
is $circle2->collides($circle4), 0;
is $circle3->collides($circle4), 0;

done_testing();

