#!/bin/bash
echo
echo "Killing all HTMLCOIN multiminer processes now!"
pkill start.sh
pkill htmlcoin-cli
echo
echo "Stopping HTMLCOIN daemon now! Please wait! Could take some time!"
echo
../HTMLCOIN/src/htmlcoin-cli stop
echo
