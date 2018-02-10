#!/bin/bash

# Setup script by cl04ker to prepare the system for running the mining scripts.

# Functions
add_ppa(){
  grep -h "bitcoin" /etc/apt/sources.list.d/* > /dev/null
  if [ $? -ne 0 ]
  then
    echo "Adding Bitcoin PPA."
    yes "" | add-apt-repository ppa:bitcoin/bitcoin
  else
    echo "Bitcoin PPA already exists!"
  fi
}

# Entrypoint...
cd ..

# Add bitcoin PPA
add_ppa && apt-get update

# Install dependancies
apt-get -qq install jq curl lolcat \
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
LAT_VER=$(curl https://api.github.com/repos/HTMLCOIN/HTMLCOIN/releases/latest -s | jq .name -r)
git clone -b $LAT_VER https://github.com/HTMLCOIN/HTMLCOIN --recursive
cd HTMLCOIN
./autogen.sh
./configure --without-gui
make -j$(nproc)
make install
make check

if [ $? != 0 ]; then
  echo "Tests Failed! Please seek support!"
  exit
else
  echo "Tests completed sucessfully! Installing now!"
  make install
fi
chown -R $(logname): ../HTMLCOIN

echo
echo -e "\e[1m\e[92mSetup complete! Now run ./linux-start.sh\e[0m"
echo
