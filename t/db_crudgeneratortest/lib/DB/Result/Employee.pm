package DB::Result::Employee;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

DB::Result::Employee

=cut

__PACKAGE__->table("employee");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'employee_id_seq'

=head2 first_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 last_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 company_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 is_deleted

  data_type: 'boolean'
  default_value: false
  is_nullable: 1

=head2 work_area_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "employee_id_seq",
  },
  "first_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "last_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "company_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "is_deleted",
  { data_type => "boolean", default_value => \"false", is_nullable => 1 },
  "work_area_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 work_area

Type: belongs_to

Related object: L<DB::Result::WorkArea>

=cut

__PACKAGE__->belongs_to(
  "work_area",
  "DB::Result::WorkArea",
  { id => "work_area_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 company

Type: belongs_to

Related object: L<DB::Result::Company>

=cut

__PACKAGE__->belongs_to(
  "company",
  "DB::Result::Company",
  { id => "company_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-06-21 12:30:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:N4ENe5hBin3kHBOBiCADhQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
