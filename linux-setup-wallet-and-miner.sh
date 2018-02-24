#!/bin/bash

# Setup script by cl04ker to prepare the system for running the HTMLCoin Wallet

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

# Install dependencies for UPNP, QR and ZMQ
apt-get -qq install \
  libminiupnpc-dev \
  libqrencode-dev \
  libzmq3-dev

# Install dependencies for Qt5
apt-get -qq install \
  libqt5gui5 \
  libqt5core5a \
  libqt5dbus5 \
  qttools5-dev \
  qttools5-dev-tools \
  libprotobuf-dev \
  protobuf-compiler

# Clone the HTMLCOIN Core repository, swtich to latest release and compile
git clone --recursive https://github.com/HTMLCOIN/HTMLCOIN
cd HTMLCOIN
git checkout `git tag | sort -V | tail -1`
./autogen.sh
./configure
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

# Download icon and make desktop file for quick launching
mkdir -p /usr/share/htmlcoin/pixmaps
wget https://cryptominded-muc3mconxtxewee6orxv.netdna-ssl.com/coin_icons/htmlcoin.png \
  -O /usr/share/htmlcoin/pixmaps/htmlcoin.png
cat <<EOT >> /usr/share/applications/htmlcoin-qt.desktop
[Desktop Entry]
Encoding=UTF-8
Name=HTMLCoin Wallet
GenericName=HTMLCoin Wallet
TryExec=htmlcoin-qt
Exec=htmlcoin-qt %F
Terminal=false
Icon=/usr/share/htmlcoin/pixmaps/htmlcoin.png
Type=Application
Categories=Application;Cryptocurrency;HTMLCoin;
Comment=HTMLCoin Wallet
EOT

echo
echo -e "\e[1m\e[92mSetup of HTMLCoin wallet complete! Search your applications menu or quick launcher for 'HTMLCoin Wallet'.\e[0m"
echo
