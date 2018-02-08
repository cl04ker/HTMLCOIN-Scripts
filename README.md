# HTMLCOIN-Scripts by cl04ker

**If you find these scripts useful, please consider donating HTMLCOIN to me. Thank you.  
My address: HXhuuAmrpNuUSoMbpKxTpZmA36uZwK4wFi**

If you need help use the GitHub issues or you can find me here: [Unofficial HTMLCOIN Mining Telegram](https://t.me/joinchat/GE3Ziw0pCU5lFZvoACOJwg)

The following scripts have been written to automate your usage of the HTMLCOIN software on Ubuntu Linux and MacOSX.

I suggest that you clone this repository under a folder called "HTMLCoin" in order to keep things tidy and organised. I keep mine at ```~/Crypto/HTMLCoin/HTMLCOIN-Scripts```

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

## linux-update-miner.sh
Run this script as root to update your mining software only (for dedicated servers): ```sudo ./linux-update-miner.sh```

## linux-update-wallet-and-miner.sh
Run this script as root to update your wallet and mining software (mainly for desktop use): ```sudo ./linux-update-wallet-and-miner.sh```

## macosx-setup-wallet-and-miner.sh

Setup wallet software on MacOSX. Run ```sudo ./macosx-setup-wallet-and-miner.sh``` to start the installation.

## macosx-start.sh

Start mining on MacOSX with this script. Run ```./macosx-start.sh``` to configure and start the miners. See linux start script for an example.

## show-blocks.sh

Run this script to show all the blocks you have mined.

```./show-blocks.sh```

~~~bash
Miner-0   Block Count:192   Thu  1 Feb 08:33:03 GMT 2018
Block Output: [   "0000000000151939dcea3c83e8571cd3de298b9bf872305424d87b6f75ebf4dd" ]
--
Miner-7   Block Count:239   Thu  1 Feb 10:41:24 GMT 2018
Block Output: [   "0000000000c9555ef05684538cbfd4e4be05716ff640780886179380cd14646a" ]
--
Miner-4   Block Count:769   Fri  2 Feb 10:50:24 GMT 2018
Block Output: [   "00000000023be58c86fea9761a3374cc1ee0001933f04dc293e0178123e5073d" ]
--
Miner-5   Block Count:913   Fri  2 Feb 17:24:44 GMT 2018
Block Output: [   "00000000020bab2d5a1d605a41efd46f21e9699869ef0a8ed31b6dd8f749dd57" ]
--
Miner-5   Block Count:980   Fri  2 Feb 20:27:52 GMT 2018
Block Output: [   "0000000004805074415c51ec0ee6334936168f8ec9f30d8e947dc2e5198e6973" ]
--
Miner-1   Block Count:1235   Sat  3 Feb 08:03:01 GMT 2018
Block Output: [   "0000000002303d8462eb2cbc2372686c58e6d5ec3a831bdd6d9e767d48418b81" ]
--
Miner-2   Block Count:1356   Sat  3 Feb 13:33:49 GMT 2018
Block Output: [   "0000000001a6b726914362f00e3f4204f9924201c0f7f6fdb02d7f1e15a362d8" ]
--
Miner-6   Block Count:1557   Sat  3 Feb 22:43:05 GMT 2018
Block Output: [   "0000000004a2f1bb4369783762c09ef0cf5a9a1fdcc8fb51edc3e43c8c870a5c" ]
--
Miner-5   Block Count:1904   Sun  4 Feb 14:30:59 GMT 2018
Block Output: [   "00000000016eb83055394ff8de244410dc2a993b203e83e056c0808c5ebce898" ]
--
Miner-0   Block Count:2133   Mon  5 Feb 00:57:52 GMT 2018
Block Output: [   "000000000259d1c218e340fb3c96ea3cc60a8388f95344d49704cdf159b0d427" ]
--
Miner-3   Block Count:2840   Tue  6 Feb 09:06:02 GMT 2018
Block Output: [   "00000000008c4d2c5f9040703842faa7f3ce39500bdd4c9b8ced87f477384a67" ]
--
Miner-4   Block Count:3196   Wed  7 Feb 01:19:08 GMT 2018
Block Output: [   "00000000016bd67b14939dd1b4247d94ffcaac5668bbdbf06536087fc8a3b1f9" ]
--
Miner-0   Block Count:3271   Wed  7 Feb 04:43:43 GMT 2018
Block Output: [   "00000000019ea52f4ea5d5d1bfef35ace3aea556d778d71f6677f882200b25c8" ]
--
Miner-3   Block Count:3304   Wed  7 Feb 06:13:00 GMT 2018
Block Output: [   "00000000061562bd640f0b456e5e5b9f7531d147411923fcde1c782b8b55cfc0" ]
--
Miner-1   Block Count:3868   Thu  8 Feb 07:51:31 GMT 2018
Block Output: [   "00000000005204a553b7b13299078bad814f2a652b7a567f5471f8ddf9067e9b" ]
~~~

## stop.sh

Use this script to stop the miners. The script will shut down all processes and may take some time. Usually no more than five minutes.

Example:
~~~
HTMLCOIN-Scripts$ ./stop.sh

Killing all HTMLCOIN multiminer processes now!

Stopping HTMLCOIN daemon now! Please wait! Could take some time!

HTMLCOIN server stopping
~~~

## watch-lolcat.sh

An attractive way to monitor the progress of your miners! Try it out!
