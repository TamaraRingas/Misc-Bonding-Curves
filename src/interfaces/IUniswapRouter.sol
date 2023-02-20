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

  function setPoolFee(uint24 _fee) external;

}