package DB::Result::WorkArea;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

DB::Result::WorkArea

=cut

__PACKAGE__->table("work_area");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'work_area_id_seq'

=head2 label

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 is_deleted

  data_type: 'boolean'
  default_value: false
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "work_area_id_seq",
  },
  "label",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "is_deleted",
  { data_type => "boolean", default_value => \"false", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 employees

Type: has_many

Related object: L<DB::Result::Employee>

=cut

__PACKAGE__->has_many(
  "employees",
  "DB::Result::Employee",
  { "foreign.work_area_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-06-21 12:30:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:621fRrkbKu/xJ0Ge2+6y7A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
