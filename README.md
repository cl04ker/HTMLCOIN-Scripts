# HTMLCOIN-Scripts by cl04ker

**If you find these scripts useful, please consider donating HTMLCOIN to me. Thank you.  
My address: HXhuuAmrpNuUSoMbpKxTpZmA36uZwK4wFi**

If you need help use the github issues or you can find me here: [Unofficial HTMLCOIN Mining Telegram](https://t.me/joinchat/GE3Ziw0pCU5lFZvoACOJwg)

The following scripts have been written to automate your usage of the HTMLCOIN software on Linux. These have been tested working on Ubuntu Server.

Please clone this repository adjacent to the HTMLCOIN folder you cloned from here: [HTMLCOIN Official Github Page](https://github.com/HTMLCOIN/HTMLCOIN)


## htmlcoin-multiminer-start.sh
Use this script to start the multicore miner. The script will start the daemon and wait until it is fully synced before asking you how many miners you want to run. The sync check is performed by using ```htmlcoin-cli getinfo``` to check the current "blocks" value ten seconds apart. When the two checks match, the script continues.

Work out how many cores your CPU has and then when the script asks you *"How many miners do you want to run?"*, just enter the number of cores you have as an integer *(MAX=4)* and then press return.

You will then be asked to enter your receive address. *I recommend that you copy this from your wallet and then paste it into the terminal if possible.*

The selected number of miners will now start and log to ```../HTMLCOIN-LOGS/htmlcoin-miner-*```.

Example:
~~~
HTMLCOIN-Scripts$ ./htmlcoin-multiminer-start.sh

HTMLCOIN server starting

We will now check that the daemon is in sync.

First block check: 79936

Second block check: 79936

How many miners do you want to run?
4

Please enter your receive address:
HXwSL5xszyYij8awNRJDaGDh3Th89atedg

Please wait while the mining threads are started...
~~~

Please see [here](#watch-logs) for information on how to watch the logs for blocks.


## htmlcoin-multiminer-stop.sh

Use this script to stop the multicore miner. The script will gracefully shut down all processes and may take some time. Usually no more than five minutes.

Example:
~~~
HTMLCOIN-Scripts$ ./htmlcoin-multiminer-stop.sh

Killing all HTMLCOIN multiminer processes now!

Stopping HTMLCOIN daemon now! Please wait! Could take some time!

HTMLCOIN server stopping
~~~


## htmlcoin-watch-logs-for-blocks.sh <a name="watch-logs"></a>

Use this script to watch the log files for any blocks that you may find.

Example:
~~~
Every 60.0s: grep -B 1 '"' ../HTMLCOIN-Logs/htmlcoin-miner-main.log

Miner-3   Block Count:118   Tue 16 Jan 12:56:16 GMT 2018
Block Output: [   "0000000000c8d1139136e01edb809f022408ea49dd45477b89092bca58ddc127" ]
~~~

You may want to occasionally remove old logs with the following command: ```rm ../HTMLCOIN-Logs/*```
