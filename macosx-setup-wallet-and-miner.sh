#!/bin/bash

USER=$(who | awk 'NR==1{print $1}')

# Entrypoint...

test -f /usr/local/bin/brew
if [ $? != 0 ]; then
  su -m $SUDO_USER -c '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \ </dev/null'
  until [ -f /usr/local/bin/brew ]
  do
    sleep 10
  done
else
  # Update Brew
  su -m $SUDO_USER -c "brew update"
fi

su -m $SUDO_USER -c "brew install cmake automake berkeley-db4 libtool miniupnpc openssl pkg-config protobuf qt5 libevent"
su -m $SUDO_USER -c "brew install boost --without-single --without-static"
su -m $SUDO_USER -c "brew install imagemagick --with-librsvg"
su -m $SUDO_USER -c "brew install lolcat watch coreutils"

ln -s /usr/local/bin/gtac /usr/local/bin/tac

# Clone HTMLCOIN repo and compile...
cd ..
git clone --recursive https://github.com/HTMLCOIN/HTMLCOIN
cd HTMLCOIN
git checkout `git tag | sort -V | tail -1`
./autogen.sh
./configure --enable-static --disable-shared
make -j$(sysctl -n hw.ncpu)
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

cd ..

chown -R $USER:$USER HTMLCOIN

# Create application bundle for quick launching the wallet
mkdir temp; cd temp; git clone https://github.com/Xeoncross/macappshell.git; cd macappshell
# Grab the icon
curl https://upload.wikimedia.org/wikipedia/commons/c/ce/HTMLcoin.png > HTMLCoin.png
# Setup the bundle
./setup.sh HTMLCoin\ Wallet HTMLCoin.png
# Copy binary to bundle
cp ../../HTMLCOIN/src/qt/htmlcoin-qt HTMLCoin\ Wallet.app/Contents/MacOS/HTMLCoin\ Wallet
# Copy bundle over to Applications directory and clean up
cp -R HTMLCoin\ Wallet.app /Applications/; rm -rf ../../temp

# Tidy up left over headers and files that upset brew doctor
rm /usr/local/include/bitcoinconsensus.h
rm /usr/local/lib/libbitcoinconsensus.la
rm /usr/local/lib/pkgconfig/libbitcoinconsensus.pc
rm /usr/local/lib/libbitcoinconsensus.a

echo "Install complete! Launch the HTMLCoin Wallet from the Applications menu or Quick Launcher."
