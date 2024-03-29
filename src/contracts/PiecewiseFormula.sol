// SPDX-License-Identifier: MIT
pragma solidity 0.8.17; 

/* ___  _                                     _            
  / _ \(_)  ___   ___   ___        __      __(_) ___   ___ 
 / /_)/| | / _ \ / __| / _ \ _____ \ \ /\ / /| |/ __| / _ \
/ ___/ | ||  __/| (__ |  __/|_____| \ V  V / | |\__ \|  __/
\/     |_| \___| \___| \___|         \_/\_/  |_||___/ \___|
*********************************************************/

import "@prb-math/sd59x18/Math.sol"; 
import "../interfaces/IPiecewiseFormula.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract PiecewiseFormula is IPiecewiseFormula, Ownable {

  /*//////////////////////////////////////////////////////////////
                          STATE VARIABLES
  //////////////////////////////////////////////////////////////*/  

  address public curve;

  /*//////////////////////////////////////////////////////////////
                       STATE CHANGING FUNCTIONS
  //////////////////////////////////////////////////////////////*/

  function setCurveAddress(address _curveAddress) external onlyOwner {
      curve = _curveAddress;
  }

  function setCurveParams() external onlyOwner {
    
  }

  /// @notice Determines the price for an input amount of MISC, in COLL.
  /// @dev The price is calculated as the integral between the endPoint(The amount of tokens sold after the user has bought the input amount) and the startPoint(the amount of tokens bought before the quote was requested) along the shifted cos curve.
  /// @param _amountMISC - The amount of MISC the user wishes to recieve a quote for in COLL. 
  /// @param _tokenDecimals - The amount of decimals of the input token, 18 for ETH and 6 for USDC. 
  /// @return price - The amount of COLL (scaled) to be transferred if the input amount of MISCtokens are bought.
  function calculatePricePiecewise(uint256 _amountMISC, uint8 _tokenDecimals) 
            external 
            view 
            returns(int256 price) {

  }
}