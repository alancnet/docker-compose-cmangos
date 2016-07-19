FROM ubuntu:14.04

ENV MYSQL_ROOT_PASSWORD="mangos" \
    MYSQL_HOST="mysql" \
    MYSQL_PORT="3306" \
    BOOST_ROOT="/boost_1_61_0" \
    GITHUB_CMANGOS="git://github.com/alancnet/mangos.git" \
    GITHUB_CMANGOS_BRANCH="tbc" \
    GITHUB_ACID="git://github.com/ACID-Scripts/TBC.git" \
    GITHUB_DATABASE="git://github.com/TBC-DB/Database.git" \
    GITHUB_MAPS="git://github.com/bilbob77/maps-tbc.git" \
    GITHUB_MMAPS_1="git://github.com/bilbob77/mmaps-1-tbc.git" \
    GITHUB_MMAPS_2="git://github.com/bilbob77/mmaps-2-tbc.git" \
    GITHUB_VMAPS="git://github.com/bilbob77/vmaps-tbc.git" \
    GITHUB_DBC="git://github.com/bilbob77/dbc-tbc.git"


RUN apt-get update && \
    apt-get install -y python-software-properties software-properties-common && \
    add-apt-repository -y ppa:george-edison55/cmake-3.x && \
    apt-get update && \
    apt-get remove -y cmake cmake-data && \
    apt-get install -y curl wget build-essential gcc g++ automake git-core autoconf make patch libmysql++-dev \
                       libtool libssl-dev grep binutils zlibc libc6 libbz2-dev cmake mysql-client && \
    echo "Installing Boost..." && \
    wget --quiet https://sourceforge.net/projects/boost/files/boost/1.61.0/boost_1_61_0.tar.gz && \
    tar -xzf /boost_1_61_0.tar.gz && \
    rm /boost_1_61_0.tar.gz && \
    cd $BOOST_ROOT && \
    ./bootstrap.sh && \
    (./b2 || true) && \
    cd / && \
    echo "Cloning Mangos Repos" && \
    git clone -b $GITHUB_CMANGOS_BRANCH --single-branch $GITHUB_CMANGOS mangos && \
    echo "Building Mangos" && \
    mkdir -p /build && \
    cd /build && \
    cmake ../mangos -DCMAKE_INSTALL_PREFIX=\../runtime -DPCH=0 -DDEBUG=0 && \
    make && \
    make install && \
    echo "Cloning WoW TBC maps" && \
    git clone $GITHUB_MAPS maps-tbc && \
    mv maps-tbc /runtime/bin/maps && \
    echo "Cloning WoW TBC move maps 1" && \
    git clone $GITHUB_MMAPS_1 mmaps-1-tbc && \
    echo "Cloning WoW TBC move maps 2" && \
    git clone $GITHUB_MMAPS_2 mmaps-2-tbc && \
    mkdir -p /runtime/bin/mmaps && \
    mv mmaps-1-tbc/* /runtime/bin/mmaps/ && \
    mv mmaps-2-tbc/* /runtime/bin/mmaps/ && \
    echo "Cloning WoW TBC Vmaps" && \
    git clone $GITHUB_VMAPS vmaps-tbc && \
    mv vmaps-tbc /runtime/bin/vmaps && \
    echo "Cloning WoW TBC dbc" && \
    git clone $GITHUB_DBC dbc-tbc && \
    mv dbc-tbc /runtime/bin/dbc && \
    apt-get remove -y build-essential gcc g++ automake autoconf make binutils cmake autoconf automake binutils \
        build-essential cmake dpkg-dev g++ g++-4.8 gcc  gcc-4.8 libtool make cmake-data && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/ /mangos /maps-classic /mmaps-classic /build

COPY bin/* /usr/local/bin/

COPY InstallFullDB.config /InstallFullDB.config

WORKDIR /runtime/bin
