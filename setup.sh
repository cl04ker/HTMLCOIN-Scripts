#!/bin/bash

add_ppa(){
  grep -h "bitcoin" /etc/apt/sources.list.d/* > /dev/null 2&>1
  if [ $? -ne 0 ]
  then
    echo "Adding Bitcoin PPA."
    add-apt-repository ppa:bitcoin/bitcoin
    return 0
  fi
  echo "Bitcoin PPA already exists!"
  return 1
}

# Install required dependancies

apt-get -qq install \
        build-essential \
        libtool \
        autotools-dev \
        automake pkg-config \
        libssl-dev \
        libevent-dev \
        bsdmainutils \
        git \
        cmake \
        libboost-all-dev \
        software-properties-common

add_ppa
