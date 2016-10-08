Screenplay XSLT
===============

This project is an attempt to develop an XSLT for processing a
screenplay XML format into PDF following a conventional screenplay
layout.

It uses xsltproc with screenplay.xsl to produce XML-FO from a simple
screenplay XML, and uses Apache FOP to produce PDF from the XML-FO.

Apache FOP: https://xmlgraphics.apache.org/fop/

The apache-fop directory is built and published on Docker Hub
as `donovan/apache-fop`

Running
-------

To run is fairly simple assuming xsltproc and docker are available.

    xsltproc screenplay.xsl sample.xml > input.fo
    docker run --rm -i -v $PWD:/s donovan/apache-fop /s/input.fo /s/output.pdf

(it would be a simple matter to run xsltproc in the container, too,
but I find it convenient for debugging the xsl to leave it out for now)

