// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/*
   ___           __              __ 
  / __\ /\ /\   /__\  /\   /\   /__\
 / /   / / \ \ / \//  \ \ / /  /_\  
/ /___ \ \_/ // _  \   \ V /  //__  
\____/  \___/ \/ \_/    \_/   \__/  
*/

interface ICurve {

  function getTokensSold() external view returns (uint256 tokensSold);

  function getMarketTransitionAddress() external view returns (address transition);

  function buyMISC(uint256 amount) external view;

  function sellMISC(uint256 amount) external;
  
}