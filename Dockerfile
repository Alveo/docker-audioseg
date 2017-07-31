FROM debian:jessie

RUN apt-get update && apt-get -y --force-yes install wget build-essential
RUN apt-get -y --force-yes install libsphere-dev

RUN mkdir /home/audioseg

RUN cd /home/audioseg &&\
    wget -q http://mirror.switch.ch/ftp/mirror/gnu/gsl/gsl-2.4.tar.gz &&\
    tar -xzf gsl-2.4.tar.gz &&\
    cd gsl-2.4 &&\
    sh ./configure &&\
    make &&\
    make install

RUN cd /home/audioseg &&\
    wget -q http://www.irisa.fr/metiss/guig/spro/spro-4.0.1/spro-4.0.1.tar.gz &&\
    tar -xzf spro-4.0.1.tar.gz &&\
    cd spro-4.0 &&\
    sh ./configure &&\
    make &&\
    make install

COPY ssad.patch /home/audioseg/ssad.patch
RUN cd /home/audioseg &&\
    wget -q https://gforge.inria.fr/frs/download.php/file/31320/audioseg-1.2.2.tar.gz &&\
    tar -xzf audioseg-1.2.2.tar.gz &&\
    patch audioseg-1.2.2/src/ssad.c ssad.patch &&\
    cd audioseg-1.2.2 &&\
    sh ./configure &&\
    make &&\
    make install


ENTRYPOINT []
