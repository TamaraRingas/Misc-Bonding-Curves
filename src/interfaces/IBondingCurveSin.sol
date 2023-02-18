// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/*    _            ___                           
 ___ (_) _ __     / __\ _   _  _ __ __   __  ___ 
/ __|| || '_ \   / /   | | | || '__|\ \ / / / _ \
\__ \| || | | | / /___ | |_| || |    \ V / |  __/
|___/|_||_| |_| \____/  \__,_||_|     \_/   \___|
****************************************************/

interface IBondingCurveSin {

  function setCurveAddress(address curveInstance) external;

  function calculatePirceSinCurve(uint256 amountMISC) external returns (uint256 price);
  
}