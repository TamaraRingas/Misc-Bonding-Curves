// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/*
 _____    __     _        __  __      _____  _____   _____    ___      __ 
/__   \  /__\   /_\    /\ \ \/ _\     \_   \/__   \  \_   \  /___\  /\ \ \
  / /\/ / \//  //_\\  /  \/ /\ \       / /\/  / /\/   / /\/ //  // /  \/ /
 / /   / _  \ /  _  \/ /\  / _\ \   /\/ /_   / /   /\/ /_  / \_// / /\  / 
 \/    \/ \_/ \_/ \_/\_\ \/  \__/   \____/   \/    \____/  \___/  \_\ \/  
**********************************************************************/

import "./MISC.sol";
import "./Curve.sol"; 
import "./CosFormula.sol";
import "./LnFormula.sol";
import "./SinFormula.sol";
import "./PiecewiseFormula.sol";
import "./UniswapRouter.sol";
import "../libraries/LibErrors.sol";
import "../libraries/LibEvents.sol";
import "@prb-math/sd59x18/Math.sol";
import "../interfaces/IMarketTransition.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

 
contract MarketTransition is IMarketTransition {
  
}