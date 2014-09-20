use strict;
use warnings;
package Math::Shape::Line;

use 5.008;
use Carp;
use Math::Shape::Vector;

# ABSTRACT: a 2d vector line object - an infinite 2d line

=head1 METHODS

=head2 new

Constructor, requires 4 values: the x,y values for the base and direction vectors.

    my $line = Math::Shape::Line->new(1, 2, 3, 4);

=cut

sub new {
    croak 'incorrect number of args' unless @_ == 5;
    my ($class, $x1, $y1, $x2, $y2) = @_;
    bless { base        => Math::Shape::Vector->new($x1, $y1),
            direction   => Math::Shape::Vector->new($x2, $y2),
          }, $class;
}

=head2 is_equivalent

Boolean method returns 1 if the line is equivalent to another line object. Requires a Math::Shape::Line object as an argument.

=cut

sub is_equivalent
{
    croak 'must pass a line object' unless $_[1]->isa('Math::Shape::Line');
    if(! $_[0]->{direction}->is_parallel($_[1]->{direction}) )
    {
        return 0;
    }
    my $base = Math::Shape::Vector->new($_[0]->{direction}->{x}, $_[0]->{direction}->{y});
    $base->subtract_vector($_[1]->{base});
    $base->is_parallel($_[0]->{direction});
}

=head2 one_one_side

Boolean method that returns 1 if both points of a line segment object are on the same side of the line. Requires a L<Math::Shape::LineSegment> object as an argument.

=cut

sub on_one_side
{
    croak 'project not called with argument of type Math::Shape::Line' unless $_[1]->isa('Math::Shape::LineSegment');
    my ($self, $segment) = @_;

    my $vector_d1 = Math::Shape::Vector->new($segment->{start}->{x}, $segment->{start}->{y});
    $vector_d1->subtract_vector($self->{base});

    my $vector_d2 = Math::Shape::Vector->new($segment->{end}->{x}, $segment->{end}->{y});
    $vector_d2->subtract_vector($self->{base});

    my $vector_n = Math::Shape::Vector->new($self->{direction}->{x}, $self->{direction}->{y});
    $vector_n->rotate_90;

    $vector_n->dot_product($vector_d1)
    * $vector_n->dot_product($vector_d2) > 0 ? 1 : 0;
}


=head2 collides

Boolean method that returns 1 if the line collides with another line or 0 if not. Requires a Math::Shape::Line object as an argument

    my $l1 = Math::Shape::Line(4, 2);
    my $l2 = Math::Shape::Line(4, 2);

    $l1->collides($l2); # 1

=cut

sub collides
{
    croak 'must pass a line object' unless $_[1]->isa('Math::Shape::Line');

    if($_[0]->{direction}->is_parallel($_[1]->{direction}))
    {
        return $_[0]->is_equivalent($_[1]);
    }
    1;
}



1;
