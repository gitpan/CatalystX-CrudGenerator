package DB::Result::Company;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

DB::Result::Company

=cut

__PACKAGE__->table("company");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'company_id_seq'

=head2 label

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 is_registered

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
    sequence          => "company_id_seq",
  },
  "label",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "description",
  { data_type => "text", is_nullable => 1 },
  "is_registered",
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
  { "foreign.company_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-06-21 12:30:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:mvFq+t95+b1DgjrP10ctpQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
