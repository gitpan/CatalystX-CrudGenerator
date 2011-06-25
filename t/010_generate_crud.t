use strict;
use warnings;

use Test::More tests => 5;    # see $test_models

use CatalystX::CrudGenerator;
use FindBin;
use lib "$FindBin::Bin/db_crudgeneratortest";
my $test_models = 'Employee,Company,WorkArea';

my $config = {
    app_name        => 'MyAPP::Name::Cool',
    schema          => 'DB',
    current_view    => 'WebsiteTemplate2',
    controller_base => 'Website::Public',
    rows_limit      => '2',
    db_connect      => "$FindBin::Bin/crudgen.db",
    lib_dir         => "$FindBin::Bin/db_crudgeneratortest/lib",
    models          => $test_models,
    output_dir      => "$FindBin::Bin/",
#   template_file   => "$FindBin::Bin/../lib/CatalystX/template/crudgenerator_template.tt2",
#TESTMODE ENABLE
    testing_mode    => 1,
};
my $cg = CatalystX::CrudGenerator->new();

foreach my $model ( split ",", $config->{ models } ) {
    $config->{model} = $model;
    $cg->configure($config);
    $cg->process();
    ok( $cg->output =~ m/(first_name|is_registered|is_deleted)/ , 'output fine');
}


########### NOW, TEST FOR OPTIONAL/REQUIRED PARAMETERS
# WITHOUT rows_limit

$config = {
    app_name        => 'MyAPP::Name::Cool',
    schema          => 'DB',
    current_view    => 'WebsiteTemplate2',
    controller_base => 'Website::Public',
    db_connect      => "$FindBin::Bin/crudgen.db",
    lib_dir         => "$FindBin::Bin/db_crudgeneratortest/lib",
    models          => "Employee",
    output_dir      => "$FindBin::Bin/",
#   template_file   => "$FindBin::Bin/../lib/CatalystX/template/crudgenerator_template.tt2",
#TESTMODE ENABLE
    testing_mode    => 1,
};

$config->{model} = $config->{ models };
$cg->configure($config);
$cg->process();
ok( $cg->output =~ m/first_name/ , 'output fine');

# WITHOUT app_name

$config = {
    schema          => 'DB',
    current_view    => 'WebsiteTemplate2',
    controller_base => 'Website::Public',
    db_connect      => "$FindBin::Bin/crudgen.db",
    lib_dir         => "$FindBin::Bin/db_crudgeneratortest/lib",
    models          => "Employee",
    output_dir      => "$FindBin::Bin/",
#   template_file   => "$FindBin::Bin/../lib/CatalystX/template/crudgenerator_template.tt2",
#TESTMODE ENABLE
    testing_mode    => 1,
};

$config->{model} = $config->{ models };
$cg->configure($config);
$cg->process();
ok( $cg->output =~ m/first_name/ , 'output fine');

