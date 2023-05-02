// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/*
 _____    __  __     _____  __    
/__   \  /__\/ _\   /__   \/ _\   
  / /\/ /_\  \ \      / /\/\ \    
 / /   //__  _\ \    / /   _\ \   
 \/    \__/  \__/    \/    \__/     
*****************************/

import "forge-std/Test.sol";
import "../src/contracts/Curve.sol";
import "../src/contracts/CosFormula1.sol";
import "../src/contracts/CosFormula2.sol";

contract CosTest is Test {

  Curve curve;
  CosFormula1 cos1;
  CosFormula2 cos2;

  address curveAddress;
  address cos1Address;
  address cos2Address;

  IERC20 USDC;
  IERC20 MISC;

  address alice = vm.addr(2);
  address bob = vm.addr(3);

  /*//////////////////////////////////////////////////////////////
                              SETUP
  //////////////////////////////////////////////////////////////*/

  function setUp() {
    USDC = new IERC20(0xe6b8a5CF854791412c1f6EFC7CAf629f5Df1c747);

  }

}