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

  while true; do
    MONEY="$(/usr/local/bin/htmlcoin-cli getinfo > /dev/null 2>&1)"
    RETVAL="$?"
    if [ $RETVAL -ne "0" ]
    then
      sleep 5
      continue
    else
      break
    fi
  done

  while true; do
    MONEY="$(/usr/local/bin/htmlcoin-cli getinfo | grep moneysupply | awk '{ print $2 }')"
    MONEY="${MONEY:: -1}"
    if [ $MONEY -eq "0" ]
    then
      sleep 5
      continue
    else
      break
    fi
  done

  echo "Connections must equal 8 to continue with mining... Please wait..."
  while true; do
    CONNECTIONS="$(/usr/local/bin/htmlcoin-cli getinfo | grep connections | awk '{ print $2 }')"
    CONNECTIONS="${CONNECTIONS:: -1}"
    echo "Connections = $CONNECTIONS"
    if [ $CONNECTIONS -lt "8" ]
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
    shopt -s lastpipe
    /usr/local/bin/htmlcoin-cli generatetoaddress 100 $RECADR 88888888 | readarray -t BLOCK
    { echo "$2   Block Count:$C   $(date)" & echo "Block Output: ${BLOCK[@]}"; } | tac | tee -a $1 $MAIN_LOG > /dev/null
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

# Visual check to make sure the daemon is in sync.
echo "Checking that the daemon is in sync. Please wait!"
echo
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

echo -e "\e[1m\e[92mStart up complete! Now run ./watch.sh to watch the logs for blocks.\e[0m"
echo
