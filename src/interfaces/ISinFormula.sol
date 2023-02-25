// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/*    _            ___                           
 ___ (_) _ __     / __\ _   _  _ __ __   __  ___ 
/ __|| || '_ \   / /   | | | || '__|\ \ / / / _ \
\__ \| || | | | / /___ | |_| || |    \ V / |  __/
|___/|_||_| |_| \____/  \__,_||_|     \_/   \___|
****************************************************/

interface ISinFormula {

  function setCurveAddress(address curveInstance) external;

  function calculatePriceSin(uint256 amountMISC, uint8 tokenDecimals) external view returns (int256 price);

}