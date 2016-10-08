FROM java:8u92-jre-alpine
MAINTAINER Donovan Kolbly <donovan@rscheme.org>

WORKDIR /fop
RUN wget -O - http://www-us.apache.org/dist/xmlgraphics/fop/binaries/fop-2.1-bin.tar.gz | tar -xzf - ; rm -rf fop-2.1/javadocs
RUN mkdir /fop/fonts
RUN wget -O /fop/fonts/RobotoMono-Regular.ttf https://fonts.gstatic.com/s/robotomono/v4/hMqPNLsu_dywMa4C_DEpY50EAVxt0G0biEntp43Qt6E.ttf
RUN wget -O /fop/fonts/RobotoMono-Bold.ttf https://fonts.gstatic.com/s/robotomono/v4/N4duVc9C58uwPiY8_59Fz5_TkvowlIOtbR7ePgFOpF4.ttf
RUN wget -O /fop/fonts/RobotoMono-Italic.ttf https://fonts.gstatic.com/s/robotomono/v4/mE0EPT_93c7f86_WQexR3OLrC4Du4e_yfTJ8Ol60xk0.ttf

ADD genmetrics /tmp
RUN /tmp/genmetrics

ADD config.xml /fop/
ENTRYPOINT [ "/fop/fop-2.1/fop", "-c", "config.xml" ]

# How to use:
#  (1) docker build -t fop .
#  (2) docker run --rm -it -v $PWD:/s -v /tmp:/d fop /s/input.fo /d/output.pdf
#
# Publish
#  docker tag fop donovan/apache-fop
#  docker push donovan/apache-fop
