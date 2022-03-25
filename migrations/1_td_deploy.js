// const Str = require('@supercharge/strings')
// const BigNumber = require('bignumber.js');

var TDErc20 = artifacts.require("ERC20TD.sol");
var evaluator = artifacts.require("Evaluator.sol");


module.exports = (deployer, network, accounts) => {
    deployer.then(async () => {
        await deployTDToken(deployer, network, accounts); 
        await deployEvaluator(deployer, network, accounts); 
        await setPermissionsAndRandomValues(deployer, network, accounts); 
        await deployRecap(deployer, network, accounts); 
    });
};

async function deployTDToken(deployer, network, accounts) {
	TDToken = await TDErc20.new("TD-AAVE-101","TD-AAVE-101",web3.utils.toBN("20000000000000000000000000000"))
	aDAIAddress = "0x43e8058dfa2ddea046180e1c57a41a1760e4ac60"
	USDCAddress = "0x5b8b635c2665791cf62fe429cb149eab42a3ced8"
	variableDebtUSDCAddress = "0x7f7d85ec65b50fb50527f784a702e35ce4e76111"
}

async function deployEvaluator(deployer, network, accounts) {
	Evaluator = await evaluator.new(TDToken.address, aDAIAddress, USDCAddress, variableDebtUSDCAddress)
}

async function setPermissionsAndRandomValues(deployer, network, accounts) {
	await TDToken.setTeacher(Evaluator.address, true)

}

async function deployRecap(deployer, network, accounts) {
	console.log("TDToken " + TDToken.address)
	console.log("Evaluator " + Evaluator.address)
}


