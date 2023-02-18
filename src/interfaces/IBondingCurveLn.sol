// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/*
 _             ___                           
| | _ __      / __\ _   _  _ __ __   __  ___ 
| || '_ \    / /   | | | || '__|\ \ / / / _ \
| || | | |  / /___ | |_| || |    \ V / |  __/
|_||_| |_|  \____/  \__,_||_|     \_/   \___|
********************************************/

interface IBondingCurveLn {
  
  function setCurveAddress(address curveInstance) external;

  function calculatePriceLn(uint256 amountMISC, uint8 tokenDecimals) external view returns (int256 price);
  
}