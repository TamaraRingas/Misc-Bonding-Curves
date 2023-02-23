// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/*
   __     ___         _____    __    __  
  /__\   /___\ /\ /\ /__   \  /__\  /__\ 
 / \//  //  /// / \ \  / /\/ /_\   / \// 
/ _  \ / \_// \ \_/ / / /   //__  / _  \ 
\/ \_/ \___/   \___/  \/    \__/  \/ \_/ 
*/

interface IUniswapRouter {

  function transferOwner(address _newOwner) external;
    
  function setPoolFee(uint24 _fee) external;

  function getTokensToMint(address _transition) external returns (int256 amount);

  function getQuote(address _tokenIn, address _tokenOut, uint256 _amountIn) external returns(uint256 amountOut);

  function createPool(address token0, address token1, uint256 amount0, uint256 amount1) external returns(address, uint256);

  function swapCOLLATERALForMISC(uint256 _amountIn) external returns (uint256 amountOut);

  function swapMISCforUSDC(uint256 _amountIn) external isActive returns (uint256 amountOut)
}