package Lido::XML;

our $VERSION = '0.01';

use Moo;
use Lido::XML::LIDO_1_0;
use XML::Compile;
use XML::Compile::Schema;
use XML::Compile::Util 'pack_type';

has 'namespace' => (is => 'ro' , default => sub {'http://www.lido-schema.org'});
has 'root'      => (is => 'ro' , default => sub {'lido'});
has 'schema'    => (is => 'lazy');
has 'reader'    => (is => 'lazy');
has 'writer'    => (is => 'lazy');

sub _build_schema {
	my $self = shift;
	my $schema = XML::Compile::Schema->new();

	my @schemes = Lido::XML::LIDO_1_0->new->content;

	for my $s (@schemes) {
	   	$schema->importDefinitions($s);
	}

	$schema;
}

sub _build_reader {
	my $self = shift;
	my $type      = pack_type $self->namespace, $self->root;
	$self->schema->compile(READER => $type);
}

sub _build_writer {
	my $self = shift;
	my $type      = pack_type $self->namespace, $self->root;
	$self->schema->compile(WRITER => $type);
}

sub parse {
	my ($self,$input) = @_;
	$self->reader->($input);
}

sub to_xml {
	my ($self,$data) = @_;
	my $doc    = XML::LibXML::Document->new('1.0', 'UTF-8');
	my $xml    = $self->writer->($doc, $data);
	$doc->setDocumentElement($xml);
	$doc->toString(1);
}

1;

__END__

=head1 NAME

Lido::XML - A Lido XML parser and writer

=head1 SYNOPSIS

    use Lido::XML

    my $lido = Lido::XML->new;

    my $perl = $lido->parser($xml_file);

    my $xml  = $lido->to_xml($perl);

=head1 DESCRIPTION

Lido in an XML Schema for Contributing Content to Cultural Heritage Repositories.
The Lido::XML parse is a software tool that understands the Lido Schema and can
parse the content of Lido XML files into a Perl hash and back.

=head1 DISCLAIMER

 * I'm no Lido expert.
 * This project was created as part of the L<Catmandu> project as an example how to create a XML parser based on a known XSD Schema.
 * All the heavy work is done by the excellent L<XML::Compile> package
 * I invite others developers to contribute to this code

=head1 CONFIGURATION

=over

=item new

Create a new Lido processor

=back

=head1 METHODS

=over 

=item parse( $file | $string )

Create a Perl hash out of a Lido input.

=item to_xml( $perl );

Transform a Perl hash back into a Lido XML record

=back

=head1 AUTHORS

Patrick Hochstenbach, C<< patrick.hochstenbach at ugent.be >>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2016 by Patrick Hochstenbach.

This is free software; you can redistribute it and/or modify it under the same terms as the Perl 5 programming language system itself.

=encoding utf8

=cut
