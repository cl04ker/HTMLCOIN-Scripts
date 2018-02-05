#!/bin/bash

# Setup script by cl04ker to prepare the system for running the HTMLCoin Wallet.

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
        libdb4.8-dev libdb4.8++-dev \
        libqt5gui5 libqt5core5a libqt5dbus5 \
        qttools5-dev qttools5-dev-tools \
        libprotobuf-dev protobuf-compiler

# Clone the HTMLCOIN Core repository and compile
git clone https://github.com/HTMLCOIN/HTMLCOIN --recursive
cd HTMLCOIN
./autogen.sh
./configure
make -j$(nproc)
make install
chown -R $(logname): ../HTMLCOIN

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
