// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IBondingCurveCos {
  
  function setCurveAddress(address curveInstance) external;

  function calculatePirceSinCurve(uint256 amountMISC) external returns (uint256 price);
  
}