FROM ubuntu:14.04

ENV MYSQL_ROOT_PASSWORD="mangos" MYSQL_HOST="mysql" MYSQL_PORT="3306" BOOST_ROOT="/boost_1_61_0"

RUN apt-get update && \
    apt-get install -y python-software-properties software-properties-common && \
    add-apt-repository -y ppa:george-edison55/cmake-3.x && \
    apt-get update && \
    apt-get remove -y cmake cmake-data && \
    apt-get install -y curl wget build-essential gcc g++ automake git-core autoconf make patch libmysql++-dev \
                       mysql-client libtool libssl-dev grep binutils zlibc libc6 libbz2-dev subversion cmake && \
    echo "Installing Boost..." && \
    wget --quiet https://sourceforge.net/projects/boost/files/boost/1.61.0/boost_1_61_0.tar.gz && \
    tar -xzf /boost_1_61_0.tar.gz && \
    rm /boost_1_61_0.tar.gz && \
    cd $BOOST_ROOT && \
    ./bootstrap.sh && \
    (./b2 || true) && \
    cd / && \
    echo "Cloning Mangos Repos" && \
    git clone git://github.com/cmangos/mangos-classic.git mangos && \
    git clone git://github.com/ACID-Scripts/Classic.git acid && \
    git clone git://github.com/classicdb/database.git classicdb && \
    echo "Building Mangos" && \
    mkdir -p /build && \
    cd /build && \
    cmake ../mangos -DCMAKE_INSTALL_PREFIX=\../mangos/run -DPCH=0 -DDEBUG=0 && \
    make && \
    make install && \
    echo "Cloning WoW Classic maps" && \
    git clone git://github.com/bilbob77/maps-classic.git maps-classic && \
    mv maps-classic/* /mangos/run/bin/ && \
    echo "Cloning WoW Classic move maps" && \
    git clone git://github.com/bilbob77/mmaps-classic.git mmaps-classic && \
    mv mmaps-classic/* /mangos/run/bin/ && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/

COPY bin/* /usr/local/bin/

COPY InstallFullDB.config /classicdb/InstallFullDB.config

WORKDIR /mangos/run/bin
