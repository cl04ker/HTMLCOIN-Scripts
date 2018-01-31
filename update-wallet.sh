#!/bin/bash
echo -e "\e[1m\e[92mChecking for HTMLCoin software updates now.\e[0m"
cd ../HTMLCOIN
CUR_VER=$(git describe --tags)
LAT_VER=$(curl https://api.github.com/repos/HTMLCOIN/HTMLCOIN/releases/latest -s | jq .name -r)
if [ "$CUR_VER" != "$LAT_VER" ]
  then
    echo -e "\e[1m\e[92mUpdate required! Updating now!\e[0m"
    git checkout $LAT_VER
    ./autogen.sh
    ./configure
    make -j$(nproc)
    make install
    echo -e "\e[1m\e[92mUpdate complete.\e[0m"
  else
    echo -e "\e[1m\e[92mNo update required.\e[0m"
fi
