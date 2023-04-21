// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./IPool.sol";
import "./ERC20TD.sol";


contract ExerciceSolution 
{
	function depositSomeTokens() external
	{
		address poolAddress = 0x7b5C526B7F8dfdff278b4a3e045083FBA4028790;
		address daiAddress = 0xBa8DCeD3512925e52FE67b1b5329187589072A55;
		// Approve dai for AAVE
		ERC20TD(daiAddress).approve(poolAddress, 10*10**18);
		// Deposit in AAVE
		IPool(poolAddress).supply(daiAddress, 10*10**18, address(this), 0);

	}

}

