package MouseX::App::Cmd;
our $VERSION = '0.01';

use Mouse;
extends qw/ App::Cmd /;

__PACKAGE__->meta->make_immutable( inline_constructor => 0 );

1;
__END__

=head1 NAME

MouseX::App::Cmd -

=head1 SYNOPSIS

  package YourApp::Cmd;
  use Mouse;

  extends qw/ MouseX::App::Cmd /;


  package YourApp::Cmd::Command::blort;
  use Mouse;

  extends qw/ MouseX::App::Cmd::Command /;

  has blortex => (
    isa           => 'Bool',
    is            => 'rw',
    cmd_aliases   => 'X',
    documentation => 'use the blortext algorithm',
  );

  has recheck => (
    isa           => 'Bool',
    is            => 'rw',
    cmd_aliases   => 'rw',
    documentation => 'recheck all results',
  );

  sub execute {
    my ($self, $opt, $args) = @_;

    # you may ignore $opt, it's in the attributes anyway

    my $result = $self->blortex ? blortex( ) : blort( );

    recheck($result) if $self->recheck;

    print $result;
  } 

=head1 DESCRIPTION

MouseX::App::Cmd is

=head1 AUTHOR

MouseX-App-Cmd E<lt>yuki@apps.magicalhat.jpE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
