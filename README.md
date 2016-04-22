# NAME

Lido::XML - A Lido XML parser and writer

# SYNOPSIS

    use Lido::XML

    my $lido = Lido::XML->new;

    my $perl = $lido->parser($xml_file);

    my $xml  = $lido->to_xml($perl);

# DESCRIPTION

Lido in an XML Schema for Contributing Content to Cultural Heritage Repositories.
The Lido::XML parse is a software tool that understands the Lido Schema and can
parse the content of Lido XML files into a Perl hash and back.

# DISCLAIMER

    * I'm no Lido expert.
    * This project was created as part of the L<Catmandu> project as an example how to create a XML parser based on a known XSD Schema.
    * All the heavy work is done by the excellent L<XML::Compile> package
    * I invite others developers to contribute to this code

# CONFIGURATION

- new

    Create a new Lido processor

# METHODS

- parse( $file | $string )

    Create a Perl hash out of a Lido input.

- to\_xml( $perl );

    Transform a Perl hash back into a Lido XML record

# AUTHORS

Patrick Hochstenbach, `patrick.hochstenbach at ugent.be`

# COPYRIGHT AND LICENSE

This software is copyright (c) 2016 by Patrick Hochstenbach.

This is free software; you can redistribute it and/or modify it under the same terms as the Perl 5 programming language system itself.
