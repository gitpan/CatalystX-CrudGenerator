

use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME         => 'CatalystX::CrudGenerator',
    VERSION_FROM => 'lib/CatalystX/CrudGenerator.pm', # finds \$VERSION
    AUTHOR       => 'Hernan Lopes (hernanlopes@gmail.com)',
    ABSTRACT     => '*BETA* generate crud (controller+templates) from schema input',
    PREREQ_PM    => {
                    'Test::Simple'              => 0.44,
                    'Moose'                     => 0,
                    'Getopt::Long'              => 0,
                    'Carp'                      => 0,
                    'Data::Dumper'              => 0,
                    'Template::Toolkit::Simple' => 0,
                    'Dir::Self'                 => 0,
                    'DBD::SQLite'               => 0,
                    'FindBin'                   => 0,
                    'DBIx::Class'               => 0,
                    'DBIx::Class::Schema'       => 0,
                    'SQL::Translator'           => 0,
                    },
    EXE_FILES    => ['scripts/crudgenerator.pl'],
);

