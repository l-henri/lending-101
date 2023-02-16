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
	TDToken = await TDErc20.new("TD-AAVE-101","TD-AAVE-101",web3.utils.toBN("42000000000000000000000000000"))
	aDAIAddress = "0xADD98B0342e4094Ec32f3b67Ccfd3242C876ff7a"
	USDCAddress = "0x65afadd39029741b3b8f0756952c74678c9cec93"
	variableDebtUSDCAddress = "0x4DAe67e69aCed5ca8f99018246e6476F82eBF9ab"
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




// truffle run verify ERC20TD@0x27Dc7374e1C5BF954Daf6Be846598Af76A33F2a2 --network goerli 
// truffle run verify Evaluator@0xaeaD98593a19074375cCf3ec22E111ce48C02c7E --network goerli 
