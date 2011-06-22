# -*- perl -*-

# t/001_load.t - check module loading and create testing directory

use Test::More tests => 2;

BEGIN { use_ok( 'CatalystX::CrudGenerator' ); }

my $object = CatalystX::CrudGenerator->new ();
isa_ok ($object, 'CatalystX::CrudGenerator');
