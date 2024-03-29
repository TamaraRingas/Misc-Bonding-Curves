// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/*                     ___                           
  ___   ___   ___     / __\ _   _  _ __ __   __  ___ 
 / __| / _ \ / __|   / /   | | | || '__|\ \ / / / _ \
| (__ | (_) |\__ \  / /___ | |_| || |    \ V / |  __/
 \___| \___/ |___/  \____/  \__,_||_|     \_/   \___|
****************************************************/

import "./MISC.sol";
import "./MarketTransition.sol";
import "../interfaces/ICurve.sol"; 
import "../libraries/LibErrors.sol";
import "../libraries/LibEvents.sol";
import "@prb-math/sd59x18/Math.sol";
import "@trigonometry/Trigonometry.sol";
import "../interfaces/ICosFormula2.sol"; 
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract CosFormula2 is ICosFormula2, Ownable { 

  address factory;
  address curve;

  constructor(
    address _factory,
    address _curve
  ) {
    factory = _factory;
    curve = _curve;
  }

  // ToDo change from Ownable calling this func to CurveFactory calling when creating a new curve instance with this as its price calculator
  function setCurveAddress(address _curveAddress) onlyOwner external {
      curve = _curveAddress;
  }

  /// @notice Determines the price for an input amount of MISC, in COLL.
  /// @dev The price is calculated as the integral between the endPoint(The amount of tokens sold after the user has bought the input amount) and the startPoint(the amount of tokens bought before the quote was requested) along the shifted cos curve.
  /// @param _amountMISC - The amount of MISC the user wishes to recieve a quote for in COLL. 
  /// @param _tokenDecimals - The amount of decimals of the input token, 18 for ETH and 6 for USDC. 
  /// @return price - The amount of COLL (scaled) to be transferred if the input amount of MISCtokens are bought.
  function calculatePriceCos2(uint256 _amountMISC, uint8 _tokenDecimals) 
            external 
            view 
            returns(int256 price) {
    require(_amountMISC > 0, "Please enter amount of tokens");
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


  }

}