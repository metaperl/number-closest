package Number::Closest;

our $VERSION = '0.03';

use Moose;

has 'number'   => (isa => 'Num',           is => 'rw', required => 1);
has 'numbers'  => (isa => 'ArrayRef[Num]', is => 'rw', required => 1);

sub analyze {
    my($self)=@_;

    my @dist = sort { $a->[1] <=> $b->[1] } map { [$_, abs($_ - $self->number)] } @{$self->numbers} ;

    \@dist
  

}

sub find {
    my($self,$amount)=@_;

    $amount ||= 1;

    my $list = $self->analyze;
    
    my $n = $amount <= scalar @$list ? $amount : scalar @$list ;

    #warn "N: $n";

    my @closest = @{$list}[0..($n-1)] ;

    my @c = map { $_->[0] } @closest;
    
    #use Data::Dumper;
    #warn Dumper \@closest, \@c;

    if ($amount == 1) {
	$c[0] ;
    } else {
	\@c;
    }

}




=head1 NAME

Number::Closest - find number(s) closest to a number in a list of numbers

=head1 SYNOPSIS

 use Number::Closest;

 my $finder = Number::Closest->new(number => $num, numbers => \@num) ;
 my $closest = $finder->find; # finds closest number
 my $closest_two = $finder->find(2) ;  # gives arrayref of two closest numbers in list
 
 # or, all in one shot
 Number::Closest->new(number => $num, numbers => \@num)->find(1) ;
 



=head1 SEE ALSO

L<http://stackoverflow.com/questions/445782/finding-closest-match-in-collection-of-numbers>

=head1 AUTHOR

Terrence Brannon, C<< <tbone at cpan.org> >>


=head1 BUGS

Please report any bugs or feature requests to C<bug-number-closest at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Number-Closest>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Number::Closest


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Number-Closest>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Number-Closest>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Number-Closest>

=item * Search CPAN

L<http://search.cpan.org/dist/Number-Closest/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 Terrence Brannon, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

1; # End of Number::Closest
