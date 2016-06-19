FROM ubuntu:14.04

# Ubuntu stuff
#apt-get update && \
#    apt-get install -y python-software-properties software-properties-common && \
#    add-apt-repository ppa:george-edison55/precise-backports && \
#    apt-get install -y cmake=3.2.3-5ppa5~precise1 && \

RUN apt-get update && \
    apt-get install -y python-software-properties software-properties-common && \
    add-apt-repository -y ppa:george-edison55/cmake-3.x && \
    apt-get update && \
    apt-get remove -y cmake cmake-data && \
    apt-get install -y curl wget build-essential gcc g++ automake git-core autoconf make patch libmysql++-dev mysql-server libtool libssl-dev grep binutils zlibc libc6 libbz2-dev subversion cmake && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/

# Install Cmake
RUN wget --quiet --output-file /tmp/cmake.sh http://www.cmake.org/files/v3.0/cmake-3.0.2-Linux-i386.sh
RUN cd /opt && (echo y && echo y) | bash /tmp/cmake.sh && ln -f -s /opt/cmake*/bin/cmake /usr/local/bin/cmake

# Install boost
RUN wget --quiet https://sourceforge.net/projects/boost/files/boost/1.61.0/boost_1_61_0.tar.gz
RUN tar -xzf /boost_1_61_0.tar.gz
ENV BOOST_ROOT=/boost_1_61_0
RUN cd $BOOST_ROOT && \
    ./bootstrap.sh && \
    ./b2 || \
    true

RUN git clone git://github.com/cmangos/mangos-classic.git mangos
RUN git clone git://github.com/ACID-Scripts/Classic.git acid
RUN git clone git://github.com/classicdb/database.git classicdb

RUN mkdir -p /build && \
    cd /build && \
    cmake ../mangos -DCMAKE_INSTALL_PREFIX=\../mangos/run -DPCH=0 -DDEBUG=0 && \
    make && \
    make install

RUN git clone git://github.com/bilbob77/maps-classic.git maps-classic
RUN git clone git://github.com/bilbob77/mmaps-classic.git mmaps-classic

RUN apt-get update
RUN apt-get install -y mysql-client
COPY initdb.sh /usr/local/bin/
COPY wait-for-mysql.sh /usr/local/bin/
COPY InstallFullDB.config /classicdb/InstallFullDB.config
ENV MYSQL_ROOT_PASSWORD="mangos" MYSQL_HOST="mysql" MYSQL_PORT="3306"

#COPY start.sh /mangos/run/bin/initdb.sh

RUN mv maps-classic/* /mangos/run/bin/ && \
    mv mmaps-classic/* /mangos/run/bin/

WORKDIR /mangos/run/bin
COPY mangosd.sh /usr/local/bin
COPY realmd.sh /usr/local/bin
