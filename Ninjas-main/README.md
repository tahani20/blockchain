# Crowdfunding 

## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)
* [System Interface](#system-interface)
* [System Scenario](#System-Scenario)
* [Setup](#setup)

## General info
Defi unpermissioned platform of funding a project or venture by raising small amounts of money from a large number of people via ethereum blockchain technology without any middleman to function or to manage a user’s information.

The campaign creators will post their project ideas in the campaign and the interested people will donate the fund to the project idea. Money is stored securely so all ether coins will be recorded and keep track in the blockchain. Where the blockchain is an immutable ledger. All transactions made through blockchain are recorded so there is no way to fraud. See  [System Scenario](#System-Scenario) for more illustration.
	
## Technologies
Project is created with:
* Solidity 
* truffle unbox Webpack
* javaScript and html
* node.js
* metamack
* openzipplen erc20

Some softwares we needed:
* Remix - Ethereum
* Visual Studio Code

## System Interface
![interface](https://user-images.githubusercontent.com/46450491/115473031-a2a28300-a243-11eb-8e31-c0bf99a0d42f.jpg)



## System Scenario
![systemArchitecture](https://user-images.githubusercontent.com/46450491/115472707-14c69800-a243-11eb-8289-f3a833f263fa.png)

	
## Setup
To run this project:
First "test" the smart contract
Write in the terminal of VS the following commands:

To initiat truffle folders:
```
$ truffle init
```
After upload the smart contract and test.js write this commands:
```
$ truffle develop
$ migrate --reset
$ test
```

Second: to write fronend with webpack we need to install trufful webpack:
```
$ npx truffle unbox webpack
```
After done index.html and index.js write this commands:
```
$ truffle compile
$ truffle migrate
$ truffle test
$ cd app
$ npm dev run 
```
