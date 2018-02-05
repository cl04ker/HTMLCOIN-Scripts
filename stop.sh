#!/bin/bash
echo
echo "Killing all HTMLCOIN multiminer processes now!"
pkill -f start.sh
pkill -f htmlcoin-cli
echo
echo "Stopping HTMLCOIN daemon now! Please wait! Could take some time!"
echo
../HTMLCOIN/src/htmlcoin-cli stop
echo
echo -e "\e[1m\e[92mShutdown of all HTMLCoin processes is complete.\e[0m"
echo
