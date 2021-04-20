# Crowdfunding 

## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)
* [System Scenario](#System Scenario)
* [Setup](#setup)

## General info
Defi unpermissioned platform of funding a project or venture by raising small amounts of money from a large number of people via ethereum blockchain technology without any middleman to function or to manage a user’s information.
	
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

## System Scenario
![](images/systemArchitecture.png)

	
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
After writing the index.html and index.js write this commands:
```
$ truffle compile
$ truffle migrate
$ truffle test
$ cd app
$ npm dev run 
```
