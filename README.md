# HTMLCOIN-Scripts by cl04ker

**If you find these scripts useful, please consider donating HTMLCOIN to me. Thank you.  
My address: HXhuuAmrpNuUSoMbpKxTpZmA36uZwK4wFi**

If you need help use the GitHub issues or you can find me here: [Unofficial HTMLCOIN Mining Telegram](https://t.me/joinchat/GE3Ziw0pCU5lFZvoACOJwg)

The following scripts have been written to automate your usage of the HTMLCOIN software on Ubuntu Linux.

I suggest that you clone this repository under a folder called ```HTMLCoin``` in order to keep things tidy and organised. I keep mine at ```~/crypto/HTMLCoin/HTMLCOIN-Scripts```

Clone this repository with ```git clone https://github.com/cl04ker/HTMLCOIN-Scripts.git``` and then use one of the setup scripts depending on what you would like to achieve.

Please also don't forget to run ```git pull``` every so often to check for any updates I have made.

## linux-setup-miner.sh
Use this script to setup the HTMLCoin software ready to be used by the ```./linux-start.sh``` script. Run the setup script as root using ```sudo ./linux-setup-miner.sh```

## linux-setup-wallet-and-miner.sh
Use this script on your Linux Desktop to install the HTMLCoin Wallet software. Run the setup script as root using ```sudo ./linux-setup-wallet-and-miner.sh```. Once complete, look for 'HTMLCoin Wallet' in your applications menu or quick launcher.

## linux-start.sh
Use this script to start the multicore miner. The script will begin by asking: *How many miners do you want to run?* Match this to the number of cores your system has. If you dont know how many cores your system has, you can run ```nproc``` to find out.

You will then be asked to enter your receive address. *I recommend that you copy this from your wallet and then paste it into the terminal if possible.*

The script will then start the daemon and wait until it is fully synced before continuing. The selected number of miners will now start and log to ```../HTMLCOIN-LOGS/htmlcoin-miner-*```.

Example:
~~~
$ ./linux-start.sh

How many miners do you want to run?
2

Please enter your receive address:
HXwSL5xszyYij8awNRJDaGDh3Th89atedg

HTMLCOIN server starting

Checking that the daemon is up.

GetInfo Return Value = 1
GetInfo Return Value = 0

Checking that the daemon is in sync. Money must be higher than 0.

Money = 0
Money = 0
Money = 0
Money = 0
Money = 0
Money = 93901014004

Connections must be greater than 4 to continue with mining... Please wait...

Connections = 3
Connections = 3
Connections = 3
Connections = 4
Connections = 5

Please wait while the miners are started!
~~~

Please see [here](#watch) for information on how to watch the logs for blocks.

## linux-update-miner.sh
Run this script as root to update your mining software only (for dedicated servers): ```sudo ./linux-update-miner.sh```

## linux-update-wallet-and-miner.sh
Run this script as root to update your wallet and mining software (mainly for desktop use): ```sudo ./linux-update-wallet-and-miner.sh```

## macosx-setup-wallet-and-miner.sh

Setup wallet software on MacOSX. Run ```sudo ./macosx-setup-wallet-and-miner.sh``` to start the installation.

## macosx-start.sh

Start mining on MacOSX with this script. Run ```./macosx-start.sh``` to configure and start the miners. See linux start script for an example.

## stop.sh

Use this script to stop the miners. The script will shut down all processes and may take some time. Usually no more than five minutes.

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

## watch-lolcat.sh

An attractive way to monitor the progress of your miners! Try it out!

You must install lolcat first by running ```sudo apt install lolcat```
