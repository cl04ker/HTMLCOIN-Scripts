#!/bin/bash

# Variables
RECADR=""
MINERS=
COUNT=0
C=1
MAIN_LOG="../HTMLCOIN-Logs/htmlcoin-miner-main.log"

# Functions
start_daemon(){
  /usr/local/bin/htmlcoind --daemon --rpcthreads=$MINERS
}

check_daemon(){
  echo "Checking that the daemon is up."
  echo
  while true; do
    /usr/local/bin/htmlcoin-cli getinfo > /dev/null 2>&1
    RETVAL="$?"
    echo "GetInfo Return Value = $RETVAL"
    if [ $RETVAL -ne "0" ]
    then
      sleep 10
      continue
    else
      break
    fi
  done

  echo
  echo "Checking that the daemon is in sync. Money must be higher than 0."
  echo
  while true; do
    MONEY="$(/usr/local/bin/htmlcoin-cli getinfo | grep moneysupply | awk '{ print $2 }' | rev | cut -c 2- | rev)"
    BLOCKS="$(/usr/local/bin/htmlcoin-cli getinfo | grep blocks | awk '{ print $2 }' | rev | cut -c 2- | rev)"
    echo "Money = $MONEY"
    echo "Blocks = $BLOCKS"
    if [ $MONEY -lt "90000000000" ]
    then
      sleep 10
      continue
    else
      break
    fi
  done

  echo
  echo "Connections must be greater than 4 to continue with mining... Please wait..."
  echo
  while true; do
    CONNECTIONS="$(/usr/local/bin/htmlcoin-cli getinfo | grep connections | awk '{ print $2 }' | rev | cut -c 2- | rev)"
    echo "Connections = $CONNECTIONS"
    if [ $CONNECTIONS -lt "5" ]
    then
      sleep 10
      continue
    else
      break
    fi
  done

}

start_mining(){
  while true; do
    declare -a BLOCK=$(/usr/local/bin/htmlcoin-cli generatetoaddress 100 $RECADR 88888888)
    { echo "$2   Block Count:$C   $(date)" & echo "Block Output: $BLOCK"; } | tac | tee -a $1 $MAIN_LOG > /dev/null
    (( C++ ))
  done &
}

# Entrypoint...

# Set up logging directory if it is not already there.
mkdir -p ../HTMLCOIN-Logs

# Remove any previous log files that may have been left from a previous mining session.
rm -f ../HTMLCOIN-Logs/*

touch $MAIN_LOG

while [ -z $MINERS ]
do
  echo
  echo -n 'How many miners do you want to run?'
  echo
  read MINERS
done

echo
echo "Please enter your receive address:"
read RECADR
echo
start_daemon
echo

# Check to make sure the daemon is in sync.
check_daemon

echo
echo "Please wait while the miners are started!"
echo
while [ $COUNT -lt $MINERS ]
do
  touch ../HTMLCOIN-Logs/htmlcoin-miner-$COUNT.log
  start_mining ../HTMLCOIN-Logs/htmlcoin-miner-$COUNT.log Miner-$COUNT
  (( COUNT++ ))
  sleep 2
done

echo "Start up complete! Now run ./watch.sh to watch the logs for blocks."
echo
