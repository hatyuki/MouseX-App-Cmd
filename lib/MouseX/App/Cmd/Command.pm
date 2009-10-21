package MouseX::App::Cmd::Command;

use Getopt::Long::Descriptive( );

use Mouse;
with    qw/ MouseX::Getopt /;
extends qw/ App::Cmd::Command /;

has usage => (
    is        => 'ro',
    isa       => 'Object',
    metaclass => 'NoGetopt',
    required  => 1,
);

has app => (
    is        => 'ro',
    isa       => 'MouseX::App::Cmd',
    metaclass => 'NoGetopt',
    required  => 1,
);

__PACKAGE__->meta->make_immutable( inline_constructor => 0 );


sub _process_args {
    my $self = shift;
    my ($args, @params) = @_;
    local @ARGV = @$args;

    my $config_from_file;
    if ( $self->meta->does_role('MouseX::ConfigFromFile') ) {
        local @ARGV = @ARGV;

        my $configfile;
        my $opt_parser = Getopt::Long::Parser->new(
            config => [ qw/ pass_through / ]
        );

        $opt_parser->getoptions( "configfile=s" => \$configfile );

        unless (defined $configfile) {
            my $cfmeta = $self->meta->find_attribute_by_name('configfile');
            $configfile = $cfmeta->default if $cfmeta->has_default;
        }

        if (defined $configfile) {
            $config_from_file = $self->get_config_from_file($configfile);
        }
    }

    my %processed = $self->_parse_argv(
        params  => { argv => \@ARGV },
        options => [ $self->_attrs_to_options($config_from_file) ],
    );

    return (
        $processed{params},
        $processed{argv},
        usage => $processed{usage},
        %{
            $config_from_file
            ? { %$config_from_file, %{$processed{params}} }
            : $processed{params}
        },
    );
}


sub _usage_format {
    shift->usage_desc;
}


1;
__END__

=pod

=head1 NAME

MouseX::App::Cmd::Command - Base class for L<MouseX::Getopt> based L<App::Cmd::Command>s.

=head1 SYNOPSIS

    use Mouse;

    extends qw(MouseX::App::Cmd::Command);

    # no need to set opt_spec
    # see MouseX::Getopt for documentation on how to specify options
    has option_field => (
        isa      => 'Str',
        is       => 'rw',
        required => 1,
    );

    sub execute {
        my ($self, $opts, $args) = @_;

        print $self->option_field; # also available in $opts->{option_field}
    }

=head1 DESCRIPTION

This is a replacement base class for L<App::Cmd::Command> classes that includes
L<MouseX::Getopt> and the glue to combine the two.

=head1 METHODS

=over 4

=item _process_args

Replaces L<App::Cmd::Command>'s argument processing in in favour of
L<MouseX::Getopt> based processing.

=back

=head1 TODO

Full support for L<Getopt::Long::Descriptive>'s abilities is not yet written.

This entails taking apart the attributes and getting at the descriptions.

This might actually be added upstream to L<MouseX::Getopt>, so until we decide
here's a functional but not very helpful (to the user) version anyway.

=cut
