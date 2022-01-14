pragma solidity ^0.6.0;

interface IExerciceSolution 
{
	function depositSomeTokens() external;

	function withdrawSomeTokens() external;

	function borrowSomeTokens() external;

	function repaySomeTokens() external;

	function doAFlashLoan() external;

	function repayFlashLoan() external;
}

