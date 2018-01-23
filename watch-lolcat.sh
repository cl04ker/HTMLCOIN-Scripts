#!/bin/bash

tail -f ../HTMLCOIN-Logs/htmlcoin-miner-main.log | lolcat -F 1.5 -a -d 50 -s 15
