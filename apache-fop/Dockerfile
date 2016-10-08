FROM java:8u92-jre-alpine
MAINTAINER Donovan Kolbly <donovan@rscheme.org>

WORKDIR /fop
RUN wget -O - http://www-us.apache.org/dist/xmlgraphics/fop/binaries/fop-2.1-bin.tar.gz | tar -xzf - ; rm -rf fop-2.1/javadocs
ENTRYPOINT [ "/fop/fop-2.1/fop" ]

# How to use:
#  (1) docker build -t fop .
#  (2) docker run --rm -it -v $PWD:/s -v /tmp:/d fop /s/input.fo /d/output.pdf
#
# Publish
#  docker tag fop donovan/apache-fop
#  docker push donovan/apache-fop
