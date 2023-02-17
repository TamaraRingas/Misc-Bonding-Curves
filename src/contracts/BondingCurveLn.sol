// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "../interfaces/IBondingCurveLn.sol";

/*
 _             ___                           
| | _ __      / __\ _   _  _ __ __   __  ___ 
| || '_ \    / /   | | | || '__|\ \ / / / _ \
| || | | |  / /___ | |_| || |    \ V / |  __/
|_||_| |_|  \____/  \__,_||_|     \_/   \___|
*/

contract BondingCurveLn {
  
  address curve;

  // ToDo change from Ownable calling this func to CurveFactory calling when creating a new curve instance with this as its price calculator
  function setCurveAddress(address _curveAddress) onlyOwner external {
      curve = _curveAddress;
  }

  /// @notice Determines the price for an input amount of MISC, in COLL.
  /// @dev The price is calculated as the integral between the endPoint(The amount of tokens sold after the user has bought the input amount) and the startPoint(the amount of tokens bought before the quote was requested) along the shifted cos curve.
  /// @param _amountMISC - The amount of MISC the user wishes to recieve a quote for in COLL. 
  /// @param _tokenDecimals - The amount of decimals of the input token, 18 for ETH and 6 for USDC. 
  /// @return price - The amount of COLL (scaled) to be transferred if the input amount of MISCtokens are bought.
  function calculatePrice(uint256 _amountMISC, uint8 _tokenDecimals) 
            external 
            view 
            returns(int256 price) {

  }
}