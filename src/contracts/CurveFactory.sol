// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/* ___    _      ___  _____    ___    __       
  / __\  /_\    / __\/__   \  /___\  /__\ /\_/\
 / _\   //_\\  / /     / /\/ //  // / \// \_ _/
/ /    /  _  \/ /___  / /   / \_// / _  \  / \ 
\/     \_/ \_/\____/  \/    \___/  \/ \_/  \_/ 
*/

import "../interfaces/ICurveFactory.sol"; 
import "../interfaces/IUniswapRouter.sol"; 
//import "./MockERC1155.sol";
import "./Curve.sol"; 
import "./MarketTransition.sol";
import "o@penzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CurveFactory is ICurveFactory {
  
}