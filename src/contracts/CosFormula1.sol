// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/*                     ___                           
  ___   ___   ___     / __\ _   _  _ __ __   __  ___ 
 / __| / _ \ / __|   / /   | | | || '__|\ \ / / / _ \
| (__ | (_) |\__ \  / /___ | |_| || |    \ V / |  __/
 \___| \___/ |___/  \____/  \__,_||_|     \_/   \___|
****************************************************/

import "./MarketTransition.sol";
import "../interfaces/ICurve.sol"; 
import "../libraries/LibErrors.sol";
import "../libraries/LibEvents.sol";
import "@prb-math/sd59x18/Math.sol";
import "@trigonometry/Trigonometry.sol";
import "../interfaces/ICosFormula1.sol"; 
import "@openzeppelin/contracts/access/Ownable.sol";

/// @notice The formula for this curve is cos(x + pi)/2 + 0.6
/// @notice This curve oscillates between a price of 0.1 & 1.1
contract CosFormula1 is ICosFormula1, Ownable { 

  address curve;

  // ToDo change from Ownable calling this func to CurveFactory calling when creating a new curve instance with this as its price calculator
  function setCurveAddress(address _curveAddress) onlyOwner external {
      curve = _curveAddress;
  }

  /// @notice Determines the price for an input amount of MISC, in COLL, along the bonding curve with the formula => Cos(x)/2.5 + 0.5
  /// @dev The price is calculated as the integral between the endPoint(The amount of tokens sold after the user has bought the input amount) and the startPoint(the amount of tokens bought before the quote was requested) along the shifted cos curve.
  /// The integral of Cos(x)/2.5 + 0.5 is 2(Sin(x))/5 + x/2
  /// @param _amountMISC - The amount of MISC the user wishes to recieve a quote for in COLL. 
  /// @param _tokenDecimals - The amount of decimals of the input token, 18 for ETH and 6 for USDC. 
  /// @return price - The amount of COLL (scaled) to be transferred if the input amount of MISCtokens are bought.
  function calculatePriceCos1(uint256 _amountMISC, uint8 _tokenDecimals) 
            external 
            view 
            returns(int256 price) {
    require(_amountMISC > 0, "Please enter an amount of tokens");
    require(_tokenDecimals == 6 || _tokenDecimals == 18, "Invalid token");

    int256 amount = int256(_amountMISC);
    int256 tokensSold = int256(ICurve(curve).getTokensSold());

    int256 startPoint = tokensSold;
    startPoint *= 1e18; // Scale, for fixed point math to work

    int256 endPoint = tokensSold + amount; 
    endPoint *= 1e18; // Scale, for fixed point math to work

    /// @notice the price is the integral between start and end points.
    /// The integral between point A and B is integral(B) - integral(A).
    SD59x18 top; // Integral of x = endPoint 
    SD59x18 bottom; // Integral at x = startPoint 
    SD59x18 denom;

    denom = wrap(1) / wrap(2);
    top = ((2 * sin(wrap(endPoint))) / denom) + (wrap(endPoint) / 2);
    bottom = ((2 * sin(wrap(startPoint))) / denom) + (wrap(startPoint) / 2);

    price = unwrap(top - bottom);

  }

    
}


