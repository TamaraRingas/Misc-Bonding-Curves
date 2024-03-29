// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/* ___  _                                     _            
  / _ \(_)  ___   ___   ___        __      __(_) ___   ___ 
 / /_)/| | / _ \ / __| / _ \ _____ \ \ /\ / /| |/ __| / _ \
/ ___/ | ||  __/| (__ |  __/|_____| \ V  V / | |\__ \|  __/
\/     |_| \___| \___| \___|         \_/\_/  |_||___/ \___|
*********************************************************/

interface IPiecewiseFormula {

  function setCurveAddress(address curveInstance) external;

  function calculatePricePiecewise(uint256 amountMISC, uint8 tokenDecimals) external view returns (int256 price);
} 