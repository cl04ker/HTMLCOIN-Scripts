#!/bin/bash

# Setup script by cl04ker to prepare the system for running the mining scripts.

# Functions
add_ppa(){
  grep -h "bitcoin" /etc/apt/sources.list.d/* > /dev/null
  if [ $? -ne 0 ]
  then
    echo "Adding Bitcoin PPA."
    yes "" | add-apt-repository ppa:bitcoin/bitcoin
    return 0
  else
    echo "Bitcoin PPA already exists!"
    return 1
  fi
}

# Entrypoint...
cd ..

# Add bitcoin PPA
add_ppa && apt-get update

# Install dependancies
apt-get -qq install \
        build-essential \
        libtool \
        autotools-dev \
        automake pkg-config \
        libssl-dev \
        libevent-dev \
        bsdmainutils \
        git cmake \
        libboost-all-dev \
        software-properties-common \
        libdb4.8-dev libdb4.8++-dev

# Clone the HTMLCOIN Core repository and compile
git clone https://github.com/HTMLCOIN/HTMLCOIN --recursive
cd HTMLCOIN
./autogen.sh
./configure --without-gui
make -j$(nproc)
make install
chown -R $(logname): ../HTMLCOIN

echo -e "\e[1m\e[5m\e[92mSetup complete! Now run ./start.sh\e[0m"
echo
