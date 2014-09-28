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

Boolean method returns 1 if circle collides with another object, else returns 0. Requires another L<Math::Shape::Vector> library object as an argument.

    my $is_collision = $circle->collides($other_circle);

=cut

sub collides
{
    my ($self, $other_obj) = @_;

    if ($other_obj->isa('Math::Shape::Circle'))
    {
        my $center = $self->{center}->subtract_vector($other_obj->{center});
        $center->length <= $self->{radius} + $other_obj->{radius} ? 1 : 0;
    }
    elsif ($other_obj->isa('Math::Shape::Vector'))
    {
        my $center = $self->{center}->subtract_vector($other_obj);
        $center->length <= $self->{radius} ? 1 : 0;
    }
    elsif ($other_obj->isa('Math::Shape::Line'))
    {
        my $center = $self->{center}->subtract_vector($other_obj->{base});
        my $project = $center->project($other_obj->{direction});

        my $base_vector = $other_obj->{base}->add_vector($project);
        $self->collides($base_vector);
    }
    elsif ($other_obj->isa('Math::Shape::LineSegment'))
    {
        # test collision of both LineSegment start/end points
        return 1 if $self->collides($other_obj->{start});
        return 1 if $self->collides($other_obj->{end});

        # test collision of nearest point on LineSegment with circle
        my $d  = $other_obj->{end}->subtract_vector($other_obj->{start});
        my $lc = $self->{center}->subtract_vector($other_obj->{start});
        my $p  = $lc->project($d);
        my $nearest = $other_obj->{start}->add_vector($p);

        $self->collides($nearest)
            && $p->length <= $d->length
            && 0 <= $p->dot_product($d)
            ? 1 : 0;
    }
    else
    {
        croak 'collides must be called with a Math::Shape::Vector library object';
    }
}
1;
