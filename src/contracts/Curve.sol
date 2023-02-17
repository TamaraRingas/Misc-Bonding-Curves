// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/*
   ___           __              __ 
  / __\ /\ /\   /__\  /\   /\   /__\
 / /   / / \ \ / \//  \ \ / /  /_\  
/ /___ \ \_/ // _  \   \ V /  //__  
\____/  \___/ \/ \_/    \_/   \__/  
*/

import "../interfaces/ICurve.sol"; 

contract Curve is ICurve {
  
  // =================== VARIABLES =================== //

  int256 immutable maxThreshold;
  int256 immutable minThreshold;
  int256 tokensSold;

  uint256 startTime;
  uint256 immutable timeoutPeriod;
  uint256 timeoutPeriodExpiry;

  bool public curveActive; // ToDo: Change to uint8 to save space
  bool public transitionConditionsMet; // ToDo: Change to uint8 
  bool public transitioned; // ToDo: Change to uint8 
  bool public curveInitialized;
  bool public nftAccess;

  address uniswapRouter;
  address marketTransition;
  address treasury;

  IERC20 COLL;
  MISC misc;
}