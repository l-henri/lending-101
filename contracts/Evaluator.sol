pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "./ERC20TD.sol";
import "./IExerciceSolution.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// import "./utils/IUniswapV2Factory.sol";
// import "./utils/IUniswapV2Pair.sol";

contract Evaluator 
{

	ERC20TD public TDAAVE;
	IERC20 public aDAI;
	IERC20 public USDC;
	IERC20 public variableDebtUSDC;

 	mapping(address => mapping(uint256 => bool)) public exerciceProgression;
 	mapping(address => IExerciceSolution) public studentExercice;
 	mapping(address => bool) public hasBeenPaired;

 	event constructedCorrectly(address erc20Address, address adaiAddress, address UsdcAddress, address variableDebtUSDCAddress);
	constructor(ERC20TD _TDAAVE, IERC20 _aDAI, IERC20 _USDC, IERC20 _variableDebtUSDC) 
	public 
	{
		TDAAVE = _TDAAVE;
		aDAI = _aDAI;
		USDC = _USDC;
		variableDebtUSDC = _variableDebtUSDC;
		emit constructedCorrectly(address(TDAAVE), address(aDAI), address(USDC), address(variableDebtUSDC));

	}

	fallback () external payable 
	{}

	receive () external payable 
	{}

	function ex1_showIDepositedTokens()
	public
	{

		// Sender should have deposited testnet aDAI
		require(aDAI.balanceOf(msg.sender) > 0, "Sender has not deposited DAI in AAVE");

		// Distributing points
		if (!exerciceProgression[msg.sender][1])
		{
			exerciceProgression[msg.sender][1] = true;
			TDAAVE.distributeTokens(msg.sender, 2);
		}

	}

	function ex2_showIBorrowedTokens()
	public
	{

		// Sender should have borrowed USDC on AAVE 
		require(variableDebtUSDC.balanceOf(msg.sender) > 0, "Sender has not borrowed USDC in AAVE");

		// Distributing points
		if (!exerciceProgression[msg.sender][2])
		{
			exerciceProgression[msg.sender][2] = true;
			TDAAVE.distributeTokens(msg.sender, 2);
		}

	}

	function ex3_showIRepaidTokens()
	public
	{

		require(exerciceProgression[msg.sender][2], "You should have completed ex2");
		// // Sender should repaid his testnet USDC
		require(variableDebtUSDC.balanceOf(msg.sender) == 0, "Sender has not deposited DAI in AAVE");

		// Distributing points
		if (!exerciceProgression[msg.sender][3])
		{
			exerciceProgression[msg.sender][3] = true;
			TDAAVE.distributeTokens(msg.sender, 2);
		}

	}

	function ex4_showIWithdrewTokens()
	public
	{

		require(exerciceProgression[msg.sender][1], "You should have completed ex1");

		// // Sender should have no more testnet aDAI
		require(aDAI.balanceOf(msg.sender) == 0, "Sender has not deposited DAI in AAVE");

		// Distributing points
		if (!exerciceProgression[msg.sender][4])
		{
			exerciceProgression[msg.sender][4] = true;
			TDAAVE.distributeTokens(msg.sender, 2);
		}

	}

	function ex5_showContractCanDepositTokens()
	public
	{
		// Reading initial aDai balance
		uint256 initialBalance = aDAI.balanceOf(address(studentExercice[msg.sender]));

		// Trigger token deposit function
		studentExercice[msg.sender].depositSomeTokens();

		// Read end balance
		uint256 endBalance = aDAI.balanceOf(address(studentExercice[msg.sender]));

		// Verify that contract did borrow
		require(initialBalance < endBalance, "Your contract did not deposit tokens");

		// Distributing points
		if (!exerciceProgression[msg.sender][5])
		{
			exerciceProgression[msg.sender][5] = true;
			TDAAVE.distributeTokens(msg.sender, 2);
		}
	}

	function ex6_showContractCanBorrowTokens()
	public
	{
		// Reading initial variableDebtUSDC balance
		uint256 initialBalance = variableDebtUSDC.balanceOf(address(studentExercice[msg.sender]));

		// Trigger token deposit function
		studentExercice[msg.sender].borrowSomeTokens();

		// Read end balance
		uint256 endBalance = variableDebtUSDC.balanceOf(address(studentExercice[msg.sender]));

		// Verify that contract did borrow
		require(initialBalance < endBalance, "Your contract did not borrow tokens");

		// Distributing points
		if (!exerciceProgression[msg.sender][6])
		{
			exerciceProgression[msg.sender][6] = true;
			TDAAVE.distributeTokens(msg.sender, 2);
		}
	}

	function ex7_showContractCanRepayTokens()
	public
	{
		// Reading initial variableDebtUSDC balance
		uint256 initialBalance = variableDebtUSDC.balanceOf(address(studentExercice[msg.sender]));

		// Trigger token deposit function
		studentExercice[msg.sender].repaySomeTokens();

		// Read end balance
		uint256 endBalance = variableDebtUSDC.balanceOf(address(studentExercice[msg.sender]));

		// Verify that contract did borrow
		require(initialBalance > endBalance, "Your contract did not repay its tokens");

		// Distributing points
		if (!exerciceProgression[msg.sender][7])
		{
			exerciceProgression[msg.sender][7] = true;
			TDAAVE.distributeTokens(msg.sender, 2);
		}
	}

	function ex8_showContractCanWithdrawTokens()
	public
	{
		// Reading initial aDai balance
		uint256 initialBalance = aDAI.balanceOf(address(studentExercice[msg.sender]));

		// Trigger token deposit function
		studentExercice[msg.sender].withdrawSomeTokens();

		// Read end balance
		uint256 endBalance = aDAI.balanceOf(address(studentExercice[msg.sender]));

		// Verify that contract did borrow
		require(initialBalance > endBalance, "Your contract did not withdraw its tokens");

		// Distributing points
		if (!exerciceProgression[msg.sender][8])
		{
			exerciceProgression[msg.sender][8] = true;
			TDAAVE.distributeTokens(msg.sender, 2);
		}
	}

	function ex9_performFlashLoan()
	public
	{	
		// Check https://docs.aave.com/developers/guides/flash-loans

		// Trigger flash loan launch function
		studentExercice[msg.sender].doAFlashLoan();

		// Read end balance
		uint256 endBalance = USDC.balanceOf(address(studentExercice[msg.sender]));

		// Your contract has to borrow 1M USDC. The USDC contract has 6 decimals
		uint256 amountToBorrow = 1000000 * 1000000;
		// Verify that contract did borrow
		require(endBalance > amountToBorrow, "Your contract does not hold 1M dollars");

		// Distributing points
		if (!exerciceProgression[msg.sender][9])
		{
			exerciceProgression[msg.sender][9] = true;
			TDAAVE.distributeTokens(msg.sender, 4);
		}
	}


	modifier onlyTeachers() 
	{

	    require(TDAAVE.teachers(msg.sender));
	    _;
	}

	function submitExercice(IExerciceSolution studentExercice_)
	public
	{
		// Checking this contract was not used by another group before
		require(!hasBeenPaired[address(studentExercice_)]);

		// Assigning passed ERC20 as student ERC20
		studentExercice[msg.sender] = studentExercice_;
		hasBeenPaired[address(studentExercice_)] = true;
			
	}

}
