// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IPriceFormula {
  
  function setCurveAddress(address curveInstance) external;

  function calculatePrice(uint256 amountMISC, uint256 tokenDecimals) external view returns (uint256 price);
  
}