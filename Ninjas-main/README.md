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
* openzipplen ERC20

Some software we needed:
* Remix - Ethereum
* Visual Studio Code

## System Interface
![interface](https://user-images.githubusercontent.com/46450491/115473031-a2a28300-a243-11eb-8e31-c0bf99a0d42f.jpg)



## System Scenario
![systemArchitecture](https://user-images.githubusercontent.com/46450491/115472707-14c69800-a243-11eb-8289-f3a833f263fa.png)

	
## Setup
To run this project:
first "test" the smart contract
write in the terminal of VS the following commands:

To initiate  truffle folders:
```
$ truffle init
```
Second: to write frontend  with webpack we need to install truffle webpack:
```
$ npx truffle unbox webpack
```
After upload the smart contract and test.js write these  commands:
```
$ truffle develop
$ migrate --reset
$ test
```
After done index.html and index.js write these  commands:
```
$ truffle compile
$ truffle migrate
$ truffle test
$ cd app
$ npm run dev
```
