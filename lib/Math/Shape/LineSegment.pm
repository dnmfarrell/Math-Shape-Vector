use strict;
use warnings;
package Math::Shape::LineSegment;

use 5.008;
use Carp;
use Math::Shape::Vector;

# ABSTRACT: a 2d vector line segment; a line with start and end points

=head1 METHODS

=head2 new

Constructor, requires 4 values: the x,y values for the start and end points

    my $line = Math::Shape::Line->new(1, 2, 3, 4);

=cut

sub new {
    croak 'incorrect number of args' unless @_ == 5;
    my ($class, $x1, $y1, $x2, $y2) = @_;
    bless { start => Math::Shape::Vector->new($x1, $y1),
            end   => Math::Shape::Vector->new($x2, $y2),
          }, $class;
}

1;
