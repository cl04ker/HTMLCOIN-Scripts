#!/bin/bash
echo
echo "Killing all HTMLCOIN multiminer processes now!"
pkill -f htmlcoin-multiminer-start
pkill -f htmlcoin-cli
echo
echo "Stopping HTMLCOIN daemon now! Please wait! Could take some time!"
echo
../HTMLCOIN/src/htmlcoin-cli stop
