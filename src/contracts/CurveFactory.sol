// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/* ___    _      ___  _____    ___    __       
  / __\  /_\    / __\/__   \  /___\  /__\ /\_/\
 / _\   //_\\  / /     / /\/ //  // / \// \_ _/
/ /    /  _  \/ /___  / /   / \_// / _  \  / \ 
\/     \_/ \_/\____/  \/    \___/  \/ \_/  \_/ 
********************************************/

import "./MISC.sol";
import "./Curve.sol"; 
import "./MockERC1155.sol"; 
import "./UniswapRouter.sol";
import "./MarketTransition.sol"; 
import "../libraries/LibErrors.sol";
import "../libraries/LibEvents.sol";
import "@prb-math/sd59x18/Math.sol";
import "../interfaces/ICurveFactory.sol"; 
import "../interfaces/IUniswapRouter.sol"; 
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract CurveFactory is ICurveFactory {
  
  // =================== VARIABLES =================== //

    IUniswapRouter2 router;

    uint256 public curveInstances = 0;
    uint256 public marketInstances = 0;

    /// @dev Where:
    /// 0 = Ln
    /// 1 = Adapted Sin 
    ///   => Sin(x) + 
    /// 2 = Adapted Cos 1 
    ///   => Cos(x)/A + B
    ///   => Default = Cos(x)/2.5 + 0.5
    /// 3 = Adapted Cos 2 (Rapid Period)
    ///   => Cos(Ax)/B + C
    ///   => Default = Cos(3x)/2 + 0.6 
    /// 4 = PieceWise (Sigmoid Approximation)
    mapping(uint8 => address) public formulaToContract;

    mapping(uint256 => address) public curveIdToAddress;

    mapping(address => address) public curveToMarketTransition;

    constructor(address _routerAddress) {
        router = IUniswapRouter2(_routerAddress);
    }

    function getCurveAddress(uint256 _curveId) external view returns (address) {
        return curveIdToAddress[_curveId];
    }

    function getMarketAddress(address _curveAddress)
        external
        view
        returns (address)
    {
        return curveToMarketTransition[_curveAddress];
    }
}