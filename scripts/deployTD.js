// Deploying the TD somewhere
// To verify it on Etherscan:
// npx hardhat verify --network sepolia <address> <constructor arg 1> <constructor arg 2>

const hre = require("hardhat");
const Str = require('@supercharge/strings')

async function main() {
  // Deploying contracts
  const ERC20TD = await hre.ethers.getContractFactory("ERC20TD");
  const Evaluator = await hre.ethers.getContractFactory("Evaluator");
  const erc20 = await ERC20TD.deploy("TD-ERC20-102-23","TD-ERC20-102-23",0);
  aDAIAddress = "0xADD98B0342e4094Ec32f3b67Ccfd3242C876ff7a"
	USDCAddress = "0x65afadd39029741b3b8f0756952c74678c9cec93"
	variableDebtUSDCAddress = "0x4DAe67e69aCed5ca8f99018246e6476F82eBF9ab"
	AAVEPool = "0x7b5c526b7f8dfdff278b4a3e045083fba4028790"
  await erc20.deployed();
  const evaluator = await Evaluator.deploy(erc20.address, aDAIAddress, USDCAddress, variableDebtUSDCAddress, AAVEPool);
  console.log(
    `ERC20TD deployed at  ${erc20.address}`
  );
  await evaluator.deployed();
  console.log(
    `Evaluator deployed at ${evaluator.address}`
  );
  
    // Setting the teacher
    await erc20.setTeacher(evaluator.address, true)

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
