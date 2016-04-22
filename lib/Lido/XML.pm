package Lido::XML;

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