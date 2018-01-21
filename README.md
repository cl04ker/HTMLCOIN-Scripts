# HTMLCOIN-Scripts by cl04ker

**If you find these scripts useful, please consider donating HTMLCOIN to me. Thank you.  
My address: HXhuuAmrpNuUSoMbpKxTpZmA36uZwK4wFi**

If you need help use the github issues or you can find me here: [Unofficial HTMLCOIN Mining Telegram](https://t.me/joinchat/GE3Ziw0pCU5lFZvoACOJwg)

The following scripts have been written to automate your usage of the HTMLCOIN software on Linux. These have been tested working on Ubuntu Server.

Pick one of the options below to get started:
1. Clone this repository with ```git clone https://github.com/cl04ker/HTMLCOIN-Scripts.git``` and then use ```./start.sh``` to download and compile the software ready for use by the other scripts.
2. If you already have the software downloaded and built then you can clone this repository adjacent to the HTMLCOIN folder you cloned from here: [HTMLCOIN Official Github Page](https://github.com/HTMLCOIN/HTMLCOIN)

Please also don't forget to run ```git pull``` every so often to check for any updates I have made.

## setup.sh
Use this script to setup the HTMLCoin software ready to be used by the ```./start.sh``` script. Run the setup script as root using ```sudo ./setup.sh```

## start.sh
Use this script to start the multicore miner. The script will begin by asking: *How many miners do you want to run?* Match this to the number of cores your system has. If you dont know how many cores your system has, you can run ```nproc``` to find out.

You will then be asked to enter your receive address. *I recommend that you copy this from your wallet and then paste it into the terminal if possible.*

The script will then start the daemon and wait until it is fully synced before continuing. The selected number of miners will now start and log to ```../HTMLCOIN-LOGS/htmlcoin-miner-*```.

Example:
~~~
HTMLCOIN-Scripts$ ./start.sh
How many miners do you want to run?
4

Please enter your receive address:
HXwSL5xszyYij8awNRJDaGDh3Th89atedg

Please wait while the mining threads are started...

HTMLCOIN server starting

We will now check that the daemon is in sync.

First block check: 89345

Second block check: 89345

Start up complete! Now run ./watch.sh to watch the logs for blocks.
~~~

Please see [here](#watch) for information on how to watch the logs for blocks.


## stop.sh

Use this script to stop the multicore miner. The script will gracefully shut down all processes and may take some time. Usually no more than five minutes.

Example:
~~~
HTMLCOIN-Scripts$ ./stop.sh

Killing all HTMLCOIN multiminer processes now!

Stopping HTMLCOIN daemon now! Please wait! Could take some time!

HTMLCOIN server stopping
~~~


## watch.sh <a name="watch"></a>

Use this script to watch the log files for any blocks that you may find.

Example:
~~~
Every 60.0s: grep -B 1 '"' ../HTMLCOIN-Logs/htmlcoin-miner-main.log

Miner-3   Block Count:118   Tue 16 Jan 12:56:16 GMT 2018
Block Output: [   "0000000000c8d1139136e01edb809f022408ea49dd45477b89092bca58ddc127" ]
~~~
