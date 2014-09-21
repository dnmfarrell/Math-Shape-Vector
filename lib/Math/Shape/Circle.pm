use strict;
use warnings;
package Math::Shape::Circle;

use 5.008;
use Carp;
use Math::Shape::Vector;

# ABSTRACT: a 2d circle

=head1 METHODS

=head2 new

Constructor, requires 3 values: the x,y values for the center point and a radius

    my $circle = Math::Shape::Circle->new(1, 2, 54);

=cut

sub new {
    croak 'incorrect number of args' unless @_ == 4;
    my ($class, $x, $y, $r) = @_;
    bless { center => Math::Shape::Vector->new($x, $y),
            radius => $r,
          }, $class;
}

=head2 collides

Boolean method returns 1 if circle collides with another circle, else returns 0. Requires another circle object as an argument.

    my $is collision = $circle->collides($other_circle);

=cut

sub collides {
    croak 'collides must be called with a Math::Shape::Circle object' unless $_[1]->isa('Math::Shape::Circle');
    my ($self, $other_circle) = @_;

    my $radius_sum = $self->{radius} + $other_circle->{radius};
    my $vector = Math::Shape::Vector->new( $self->{center}->{x}, $self->{center}->{y} );
    $vector->subtract_vector($other_circle->{center});
    $vector->length <= $radius_sum ? 1 :0;
}

1;
