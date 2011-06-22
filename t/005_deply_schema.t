use strict;
use warnings;

use Test::More tests => 1;                      # last test to print
require_ok( 'DBD::SQLite' );

use FindBin;
use lib "$FindBin::Bin/db_crudgeneratortest/lib";
use DB;
# my $schema = DB->connect( 'dbi:Pg:dbname=crudgeneratortest','hernan','aa'); #use POSTGRES
my $sqlite_db_file = "$FindBin::Bin/crudgen.db";
unlink( $sqlite_db_file );
my $schema = DB->connect( "dbi:SQLite:$sqlite_db_file",'','');
my $stmt = "DROP TABLE IF EXISTS employee;DROP TABLE IF EXISTS company; DROP TABLE IF EXISTS work_area;";
$schema->storage->dbh->prepare( $stmt )->execute;
$schema->deploy();

my $company = $schema->resultset( 'Company' );
$company = $company->search( {
    label => 'My Company #1',
} );

if ( $company->count == 0 ) {
    my $stmt = "INSERT INTO company ( id, label, description, is_registered ) values ( '1', 'My Company #1','Our company #1 descriptions..', '1')";
    $schema->storage->dbh->prepare( $stmt )->execute;
    $stmt    = "INSERT INTO company ( id, label, description, is_registered ) values ( '2', 'My Company #2','Our company #2 descriptions..', '1')";
    $schema->storage->dbh->prepare( $stmt )->execute;
    $stmt    = "INSERT INTO company ( id, label, description, is_registered ) values ( '3', 'My Company #3','Our company #3 descriptions..', '1')";
    $schema->storage->dbh->prepare( $stmt )->execute;

}

my $workarea = $schema->resultset( 'WorkArea' )->search( {
    label => 'Garage',
} );
if ( $workarea->count == 0 ) {
    $workarea->new_result( {
        id => 1,
        label => 'Garage',
    } )->insert();
    $workarea->new_result( {
        id => 2,
        label => 'Office',
    } )->insert();
    $workarea->new_result( {
        id => 3,
        label => 'Back-Office',
    } )->insert();
}

my $employee = $schema->resultset( 'Employee' )->search( {
    first_name => 'Joe',
} );
if ( $employee->count == 0 ) {
    my $stmt = "INSERT INTO employee ( id, first_name, last_name, company_id , work_area_id ) VALUES ( '1', 'Joe', 'Sylva', '1', '3' )";
    $schema->storage->dbh->prepare( $stmt )->execute;
    $stmt    = "INSERT INTO employee ( id, first_name, last_name, company_id , work_area_id ) VALUES ( '2', 'Mary', 'Johanes', '1', '2' )";
    $schema->storage->dbh->prepare( $stmt )->execute;
    $stmt    = "INSERT INTO employee ( id, first_name, last_name, company_id , work_area_id ) VALUES ( '3', 'João', 'Sylva', '2', '1' )";
    $schema->storage->dbh->prepare( $stmt )->execute;
}

