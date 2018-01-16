#!/bin/bash

# Variables
RECADR=""
MINERS=
COUNT=0
C=1
MAIN_LOG="../HTMLCOIN-Logs/htmlcoin-miner-main.log"

# Functions
start_daemon(){
  ../HTMLCOIN/src/htmlcoind --daemon
}

check_blocks(){
  while true; do
    BLOCK="$(../HTMLCOIN/src/htmlcoin-cli getinfo | grep blocks | awk '{ print $2 }')"
    BLOCK="${BLOCK:: -1}"
    echo
    echo "First block check: $BLOCK"

    sleep 10

    NEXT_BLOCK="$(../HTMLCOIN/src/htmlcoin-cli getinfo | grep blocks | awk '{ print $2 }')"
    NEXT_BLOCK="${NEXT_BLOCK:: -1}"
    echo
    echo "Second block check: $NEXT_BLOCK"

    if [ $BLOCK -ne $NEXT_BLOCK ]
    then
      continue
    else
      break
    fi
  done
}

start_mining(){
  while true; do
    shopt -s lastpipe
    ../HTMLCOIN/src/htmlcoin-cli generatetoaddress 100 $RECADR 88888888 | readarray -t BLOCK
    { echo "$2   Block Count:$C   $(date)" & echo "Block Output: ${BLOCK[@]}"; } | tac | tee -a $1 $MAIN_LOG > /dev/null
    (( C++ ))
  done &
}

# Entrypoint...

# Set up logging directory if it is not already there.
mkdir -p ../HTMLCOIN-Logs

# Remove any previous log files that may have been left from a previous mining session.
rm ../HTMLCOIN-Logs/*

touch $MAIN_LOG

echo
start_daemon
echo

# Visual check to make sure the daemon is in sync.
echo "We will now check that the daemon is in sync."
sleep 5
check_blocks
echo

while [ -z $MINERS ]
do
  echo -n 'How many miners do you want to run?'
  echo
  read MINERS
done

echo
echo "Please enter your receive address:"
read RECADR

echo
echo "Please wait while the mining threads are started..."

while [ $COUNT -lt $MINERS ]
do
  touch ../HTMLCOIN-Logs/htmlcoin-miner-$COUNT.log
  start_mining ../HTMLCOIN-Logs/htmlcoin-miner-$COUNT.log Miner-$COUNT
  (( COUNT++ ))
  sleep 1
done
