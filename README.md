# Lending 101

## Introduction
Welcome! This is an automated workshop that will guide you into using AAVE and doing a simple integration in a smart contract.
It is aimed at developpers that are familiar with Solidity and ERC20 

## How to work on this TD
### Introduction
The TD has two components, deployed on the goerli testnet:
- An ERC20 token, ticker TD-AAVE-101, that is used to keep track of points 
- An evaluator contract, that is able to mint and distribute TD-AAVE-101 points

Your objective is to gather as many TD-AAVE-101 points as possible. Please note :
- The 'transfer' function of TD-AAVE-101 has been disabled to encourage you to finish the TD with only one address
- You can answer the various questions of this workshop with different contracts. However, an evaluated address has only one evaluated contract at a time. To change the evaluated contract associated with your address, call `submitExercice()`  with that specific address.
- In order to receive points, you will have to do execute code in `Evaluator.sol` such that the function `TDERC20.distributeTokens(msg.sender, n);` is triggered, and distributes n points.
- This repo contains an interface `IExerciceSolution.sol`. Your ERC20 contract will have to conform to this interface in order to validate the exercice; that is, your contract needs to implement all the functions described in `IExerciceSolution.sol`. 
- A high level description of what is expected for each exercice is in this readme. A low level description of what is expected can be inferred by reading the code in `Evaluator.sol`.
- The Evaluator contract sometimes needs to make payments to buy your tokens. Make sure he has enough ETH to do so! If not, you can send ETH directly to the contract.

### Getting to work
- Claim testnet ETH on [this faucet](https://goerlifaucet.com/)
- Claim fake tokens from AAVE's faucet. Go to their [website](https://app.aave.com/), activate testnet mode, and find the faucet 
- Clone the repo on your machine
- Install the required packages `npm install truffle`, `npm install @openzeppelin/contracts@3.4.1` , `npm install @truffle/hdwallet-provider`, `npm i @supercharge/strings`
- Rename `example-truffle-config.js` to `truffle-config.js` . That is now your truffle config file.
- Configure a seed for deployment of contracts in your truffle config file
- Register for an infura key and set it up in your truffle config file
- Download and launch Ganache
- Test that you are able to connect to the ganache network with `truffle console`
- Test that you are able to connect to the kovan network with `truffle console --network kovan`
- To deploy a contract, configure a migration in the [migration folder](migrations). Look at the way the TD is deploy and try to iterate
- Test your deployment in Ganache `truffle migrate`
- Deploy on Kovan `truffle migrate --network kovan --skip-dry-run`


## Points list
### Setting up
- Create a git repository and share it with the teacher
- Install truffle and create an empty truffle project. Create an infura API key to be able to deploy to the Kovan testnet

### AAVE basics
Using [Aave's website](https://app.aave.com/)
- Activate the testnet option by clicking on the wheel in the top right part of the screen
- Deposit assets in AAVE and call `ex1_showIDepositedTokens()` to get points (2 pts)
- Borrow assets from AAVE and call `ex2_showIBorrowedTokens()` to get points (2 pts)
- Repay assets to AAVE and call `ex3_showIRepaidTokens()` to get points (2 pts)
- Withdraw assets from AAVE and call `ex4_showIWithdrewTokens()` to get points (2 pts)

### AAVE integration
- Write a smart contract that deposits assets in AAVE and call `ex5_showContractCanDepositTokens()` to get points (2 pts)
- Write a smart contract that borrow assets from AAVE and call `ex6_showContractCanBorrowTokens()` to get points (2 pts)
- Write a smart contract that repays assets to AAVE and call `ex7_showContractCanRepayTokens()` to get points (2 pts)
- Write a smart contract that withdraw assets from AAVE and call `ex8_showContractCanWithdrawTokens()` to get points (2 pts)

### Flashloan
- Write a smart contract that uses a FlashLoan (4 pts)

### Extra points
Extra points if you find bugs / corrections this TD can benefit from, and submit a PR to make it better.  Ideas:
- Adding a way to check the code of a specific contract was only used once (no copying) 
- Publish the code of the Evaluator on Etherscan using the "Verify and publish" functionnality 

## TD addresses
- Points contracts [`0x27Dc7374e1C5BF954Daf6Be846598Af76A33F2a2`](https://goerli.etherscan.io/address/0x27Dc7374e1C5BF954Daf6Be846598Af76A33F2a2)
- Evaluator [`0xaeaD98593a19074375cCf3ec22E111ce48C02c7E`](https://goerli.etherscan.io/address/0xaeaD98593a19074375cCf3ec22E111ce48C02c7E)


