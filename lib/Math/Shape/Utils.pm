use strict;
use warnings;
package Math::Shape::Utils;

use Math::Trig ':pi';

# ABSTRACT: Utility methods used by the Math::Shape::Vector module

BEGIN {
    require Exporter;
    use base qw(Exporter);
    our @EXPORT = qw(degrees_to_radians radians_to_degrees overlap equal_floats minimum maximum);
    our @EXPORT_OK = ();
}

sub degrees_to_radians
{
    $_[0] * pi / 180.0;
}

sub radians_to_degrees
{
    $_[0] / pi * 180.0;
}

sub overlap
{
    my ($minA, $maxA, $minB, $maxB) = @_;
    $minB <= $maxA && $minA <= $maxB ? 1 : 0;
}

sub equal_floats
{
    my $threshold = 1.0 / 8192.0;
    abs($_[0] - $_[1]) < $threshold ? 1 : 0;
}

sub minimum
{
    $_[0] < $_[1] ? $_[0] : $_[1];
}

sub maximum
{
    $_[0] > $_[1] ? $_[0] : $_[1];
}

1;
