#!/usr/bin/perl -w

use Moose;
use Getopt::Long;
use Carp;
use Data::Dumper;
use lib "../lib";
use CatalystX::CrudGenerator;

my $db_connect = '';              #ie. 'dbi:Pg:dbname=mysitedb'
my $db_pass = '';                 #ie. 'mypassword7748'
my $db_user = '';                 #ie. 'joeuser'
my $models = '';                  #ie. Product,Client
my $app_name = '';                #ie. My::App::Name
my $schema = '';                  #ie. DB, DBSchema, Data::Base::Schema
#my $models = [ qw/Category/ ];   #ie. Track, Client, User ( ie from DB::Schema::Track )
my $current_view = '' ;           #ie. Admin                        #string
my $rows_limit = 3;               #ie. 15                           #integer
my $show_help = 0;
my $controller_base = '';         #ie. 'Website::Public' as in: Myapp::Controller::Website::Public...
my $lib_dir = '';                 #ie. /websites/catalyst/MyAPP/lib
my $template_file = '';           #ie. 'crudgenerator_template.tt2'
my $output_dir = '';              #ie. '/catalyst/myapp'

my $res = GetOptions (
    'db_connect=s' => \$db_connect, #db connection string ex dbi:Pg:dbname=MyDatabase
    'db_pass=s' => \$db_pass,
    'db_user=s' => \$db_user,
    'models=s' => \$models,
    'app_name=s' => \$app_name,
    'schema=s' => \$schema,
    'current_view=s' => \$current_view,
    'rows_limit=i' => \$rows_limit,
    'controller_base=s' => \$controller_base,
    'lib_dir=s' => \$lib_dir,
    'template_file=s' => \$template_file,
    'output_dir=s' => \$output_dir,
    help => \$show_help,
);   

if ( $show_help == 1 ) {
    my $help = <<"TEXTHELP";
---------------- CatalystX::CrudGenerator ----------------------
~\$ CatalystX::CrudGenerator --db_connect=dbi:Pg:dbname=MyDB \\ 
~\$   --db_user=joe \\ 
~\$   --db_pass=mypass \\ 
~\$   --models=User,Client,Product \\ 
~\$   --schema=DB \\ 
~\$   --rows_limit=15 \\ 
~\$   --current_view=WebsiteStandardView \\
~\$   --controller_base=Website::Public 
~\$   --lib_dir=/websites/catalyst/MyAPP/lib 
~\$   --template_file=crudgenerator_template.tt2
~\$   --output_dir=/catalyst/MY_APP_DIR

---------- Argument descriptions

--db_connect          expects db connection string
--db_user             expects a db username       
--db_pass             expects a db password       
--models              one or more model separated by comma
--schema              the schema name
--rows_limit          limit sql query rows on listing
--current_view        define the which view should be used
--controller_base     set controller base,ie...Controller::Base
--lib_dir             points to DBSchema/myapp lib dirs, ie:
                      /sites/MyAPP/lib   
--template_file       crudgenerator_template.tt2
--output_dir          output directory ie. /sites/my_app/
--app_name            application name ie. MyAPP::Name::Cool

TEXTHELP
    print $help;
    exit 1 ;
}

print "define db_connect to proceed\nCatalystX::CrudGenerator --help\n" 
    and croak if $db_connect eq '';

print "you have not defined db_pass. using none/default" 
    and carp if $db_pass eq '';

print "you have not defined db_user. using none/default" 
    and carp if $db_user eq '';

print "define models to proceed\nCatalystX::CrudGenerator --help" 
    and croak if $models eq '';

print "define app_name to proceed\nCatalystX::CrudGenerator --help" 
    and croak if $app_name eq '';

print "define schema to proceed\nCatalystX::CrudGenerator --help" 
    and croak if $schema eq '';
    
print "define current_view to proceed\nCatalystX::CrudGenerator --help" 
    and croak if $current_view eq '';

print "define lib_dir to proceed\nCatalystX::CrudGenerator --help" 
    if $lib_dir eq '';

my $config = {
    app_name => $app_name,
    template_file => $template_file,
    schema => $schema,
    current_view => $current_view,
    controller_base => $controller_base,
    rows_limit => $rows_limit,
    db_connect => $db_connect,
    db_pass => $db_pass,
    db_user => $db_user,
    lib_dir => $lib_dir,
    output_dir => $output_dir, 
};

my $cg = CatalystX::CrudGenerator->new( );

foreach my $model ( split ",", $models ) {
    $config->{ model } = $model;
    $cg->configure( $config );
    $cg->process( );
}

1;
