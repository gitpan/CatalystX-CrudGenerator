package CatalystX::CrudGenerator;
use Moose;
use Template::Toolkit::Simple;
use Data::Dumper;
use Carp;
use Dir::Self; # enables __DIR__ (module self dir)
use lib; 

our $VERSION = '0.01';

has schema => (
    is => 'rw',
    isa => 'Any',
);

has config => (
    is => 'rw',
    isa => 'HashRef',
    default => sub {{}},
);

has output => (
    is => 'rw',
    isa => 'Any',
    default => '',
);

sub get_result_source {
    my ( $self, $config ) = @_;
    my $result_source = $self->schema->source( $config->{ model } );
    $config->{ primary_columns } = [ $result_source->primary_columns ];
    $config->{ columns } = [ $result_source->columns ];
    return $config;
}

sub configure {
    my ( $self , $config ) = @_;
    $self->config( $config );
    $config = $self->config;
    my $libdir = $config->{ lib_dir };
    lib->import( $libdir );
    my $schema = $config->{ schema };
    extends $schema;
    $self->schema( 
        $schema->connect( 
            $config->{ db_connect } , 
            $config->{ db_user } , 
            $config->{ db_pass } ,
        )
    );
    $config = $self->get_result_source( $config );
}

sub process {
    my ( $self ) = @_;
    $self->generate_crud( $self->config );
}

sub get_filepath {
    my ( $self, $filename ) = @_; 
    my $file = {};
    if ( $filename =~ m{/} ) {
        if ( $filename =~ m{(.+)/([^/]+)$}i ) {
#something/filename 
            $file->{ path } = $1;
            $file->{ file } = $2;
        } elsif ( $filename =~ m{^/([^/]+)$}i ) {
            $file->{ path } = $1;
            $file->{ file } = $2;
#/filename 
        } 
    } elsif ( $filename =~ m{^([^/]+)$}i ) {
            $file->{ path } = "./";
            $file->{ file } = $1;
# filename without /
    }
    return $file;
}

sub generate_crud {
    my ( $self, $config) = @_;
    my $tt = Template::Toolkit::Simple->new( );
    my $file;
    if ( defined $config->{ template_file } 
             and $config->{ template_file } ne '' ) {
        $file = $self->get_filepath( $config->{ template_file } );
    } else {
        $file = $self->get_filepath( __DIR__ . '/template/crudgenerator_template.tt2' );
    }

    my $output = $tt
        ->path( $file->{ path } )
        ->data( $config )
        ->post_chomp
        ->start_tag( '<%' )
        ->end_tag( '%>' )
        ->render( $file->{ file } );
    my $path = $config->{output_dir};
    if ( $path =~ m{(.+)/$} ) {
    } elsif ( $path =~ m{(.*)[^/]$}) {
        $path = $path . '/';
    }
    my $filename = join "" , $path ,$config->{model}.".pm";
    if ( defined $config->{testing_mode}
             and $config->{testing_mode} == 1 ) {
        $self->output( $output );
    } else {
        if ( -e $filename ) {  
            warn "FILE-EXISTS: $filename ";
            return;
        } else {
            open FILE, ">$filename" or die $!;
            print FILE $output;
            close FILE;
        }
    }
}

=head1 NAME

    CatalystX::CrudGenerator - output crud (controller+templates) from schema input**BETA

=head1 SYNOPSIS

    -------------------- Argument descriptions ---------------------

    --db_connect          expects db connection string:
                          ie. dbi:Pg:dbname=MyDataBase
                          ie. dbi:SQLite:/databases/myDataBase.db
    --db_user             expects a db username       
    --db_pass             expects a db password       
    --models              one or more model separated by comma
    --schema              the schema name
    --rows_limit          limit sql query rows on listing
    --current_view        define the which view should be used
    --controller_base     define the which view should be used
    --lib_dir             points to DBSchema/myapp lib dirs, ie:
    --template_file       crudgenerator_template.tt2
    --output_dir          default is local dir (the dir you are in)
    
    ~\$ crudgenerator.pl --help

    ~\$ crudgenerator.pl --db_connect=dbi:Pg:dbname=MyDataBase \\ 
    ~\$   --db_user=joe \\                                #OPTIONAL
    ~\$   --db_pass=mypass \\                             #OPTIONAL
    ~\$   --models=User,Client,Product \\                 #REQUIRED
    ~\$   --schema=DB \\                                  #REQUIRED 
    ~\$   --rows_limit=15 \\                              #OPTIONAL
    ~\$   --current_view=WebsiteStandardView \\           #REQUIRED
    ~\$   --controller_base=Website::Public \\            #REQUIRED
    ~\$   --lib_dir=/websites/catalyst/MyAPP/lib \\       #REQUIRED
    ~\$   --template_file=crudgenerator_template.tt2 \\   #OPTIONAL
    ~\$   --output_dir=.                                  #OPTIONAL

    to preview: http://localhost:3000/crud/* 

=head1 DESCRIPTION

    CatalystX::CrudGenerator will attempt to generate crud template & controllers for your model.
    The ideal for CatalystX::CrudGenerator:
      - Be simple, meaning: just output me a Controller.pm
      - Allow custom template, skin sharing, templates with js widgets etc.
      - Generate me a Controller.pm i can use and check out the results.
    Note: The standard template works best with blueprint css. 

    *OBS* There is some work todo. I dont think its ready for your project out-of-the-box yet.
    Expect changes for this early version for CatalystX::CrudGenerator
    it needs some template changes. However this version might inspire your
    crud generation needs.

=head1 TEMPLATES

    You can use / modify the default template. its located in:

        lib/CatalystX/template/crudgenerator_template.tt2

    Copy and modify it for custom generation. 
    Then use "crudgenerator.pl --template_file.."

=head1 AUTHOR

    Hernan Lopes
    CPAN ID: HERNAN
    HERNAN
    hernanlopes@gmail.com
    -

=head1 COPYRIGHT

This program is free software licensed under the...

	The BSD License

The full text of the license can be found in the
LICENSE file included with this module.


=head1 SEE ALSO

perl(1).

=cut

1;
