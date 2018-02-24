#!/bin/bash

# Setup script by cl04ker to prepare the system for running the mining scripts.

# Functions
add_ppa(){
  grep -h "bitcoin" /etc/apt/sources.list.d/* 2&>1 > /dev/null
  if [ $? -ne 0 ]
  then
    echo "Adding Bitcoin PPA."
    yes "" | add-apt-repository ppa:bitcoin/bitcoin
  else
    echo "Bitcoin PPA already exists!"
  fi
}

# Entrypoint...
USER=$(who | awk 'NR==1{print $1}')

cd ..

# Add bitcoin PPA
add_ppa && apt-get update

# Install dependencies
apt-get -qq install \
  automake \
  autotools-dev \
  bsdmainutils \
  build-essential \
  cmake \
  git \
  libevent-dev \
  libssl-dev \
  libtool \
  lolcat \
  pkg-config \
  software-properties-common

# Install BerkeleyDB 4.8
apt-get -qq install \
  libdb4.8-dev libdb4.8++-dev

# Clone the HTMLCOIN Core repository, swtich to latest release and compile
git clone --recursive https://github.com/HTMLCOIN/HTMLCOIN
cd HTMLCOIN
git checkout `git tag | sort -V | tail -1`
./autogen.sh
./configure --without-gui
make -j$(nproc)
echo "Build complete!"

# Perform tests
make check
if [ $? != 0 ]; then
  echo "Tests Failed! Please seek support!"
  exit
else
  echo "Tests completed sucessfully! Installing now!"
  make install
fi

chown -R $USER:$USER ../HTMLCOIN

echo
echo -e "\e[1m\e[92mSetup complete! Now run ./linux-start.sh\e[0m"
echo
