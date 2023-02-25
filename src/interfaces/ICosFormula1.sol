// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/*                     ___                           
  ___   ___   ___     / __\ _   _  _ __ __   __  ___ 
 / __| / _ \ / __|   / /   | | | || '__|\ \ / / / _ \
| (__ | (_) |\__ \  / /___ | |_| || |    \ V / |  __/
 \___| \___/ |___/  \____/  \__,_||_|     \_/   \___|
****************************************************/

interface IBondingCurveCos {
  
  function setCurveAddress(address curveInstance) external;

  function calculatePriceCos1(uint256 amountMISC, uint8 tokenDecimals) external view returns (int256 price);

}