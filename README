A simple command-line tool for generating HTML documentation from RDFS/OWL schemas

INSTALLATION

dowl is available as a gem, so you can just do:

[sudo] gem install dowl

To install from a source simply do:

rake install

Both options will give you a new command-line application called dowl.

The application takes two parameters. The first parameter is the location of the schema file to parse the second parameter is optional and is the location of an ERB file that contains the template for output. A default template is provided and can be customized for specific purposes.

The script sends its output to STDOUT so just pipe it into a file.

E.g:

dowl examples/example.ttl >/tmp/example.html

The script will automatically include the contents of introduction.html, if found in the same directory as the schema, into the documentation. This file should contain an HTML fragment.
