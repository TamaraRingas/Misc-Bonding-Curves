// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/* ___    _      ___  _____    ___    __       
  / __\  /_\    / __\/__   \  /___\  /__\ /\_/\
 / _\   //_\\  / /     / /\/ //  // / \// \_ _/
/ /    /  _  \/ /___  / /   / \_// / _  \  / \ 
\/     \_/ \_/\____/  \/    \___/  \/ \_/  \_/ 
********************************************/

import "./Curve.sol";  
import "./UniswapRouter.sol";
import "./MarketTransition.sol"; 
import "../libraries/LibErrors.sol";
import "../libraries/LibEvents.sol";
import "@prb-math/sd59x18/Math.sol";
import "../interfaces/ICurveFactory.sol"; 
import "../interfaces/IUniswapRouter.sol"; 
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

contract CurveFactory is ICurveFactory {
  
  // =================== VARIABLES =================== //

    IUniswapRouter2 router;
    Curve curve;

    uint32 public curveInstances = 0;
    uint32 public marketInstances = 0;

    /// @dev Where:
    /// 0 = Ln
    /// 1 = Adapted Sin 
    ///   => Sin(x + A)/B + C
    ///   => Default = Sin(x + (3pi/2))/2 + 0.5
    /// 2 = Adapted Cos 1 
    ///   => Cos(x + A)/B + C
    ///   => Default = Cos(x)/2.5 + 0.5
    /// 3 = Adapted Cos 2 (Rapid Period)
    ///   => Cos(Ax + B)/C + D
    ///   => Default = Cos(3x)/2 + 0.6 
    /// 4 = PieceWise (Straight Line)
    mapping(uint256 => address) public formulaToContractAddress;

    mapping(uint32=> address) public curveIdToAddress;

    mapping(address => address) public curveToMarketTransition;

    // =================== CONSTRUCTOR =================== //

    constructor(address _routerAddress) {
        router = IUniswapRouter2(_routerAddress);
    }

    // =================== GETTERS =================== //

    function getCurveAddress(uint256 _curveId) external view returns (address) {
        return curveIdToAddress[_curveId];
    }

    function getPriceFormulaAddress(uint256 _formula) external view returns (address) {
        return formulaToContractAddress[_formula];
    }

    function getMarketAddress(address _curveAddress)
        external
        view
        returns (address)
    {
        return curveToMarketTransition[_curveAddress];
    }

    // =================== GENERAL =================== //

    function createBondingCurve(
        address _collateralAddress,
        address _miscAddress,
        address _nftAddress,
        address _treasuryAddress,
        address _uniswapRouter,
        address _marketTransition,
        uint8 _formula
    ) external onlyOwner returns (address[2] memory) {
        if (_collateralAddress == address(0)) revert LibErrors.ZeroAddress();
        if (_miscAddress == address(0)) revert LibErrors.ZeroAddress();

        curve = new Curve(
            _collateralAddress,
            _miscAddress,
            _nftAddress,
            _treasuryAddress,
            _uniswapRouter,
            _marketTransition,
            formulaToContract(_formula)
        );

        curve.transferOwnership(msg.sender);

        curveIdToAddress[curveInstance] = address(curve);

        emit CurveInstanceCreated(curveInstance, address(newCurve));

        ++curveInstance;

        MarketTransition transition = new MarketTransition(
            address(curve),
            address(router),
            _collateralAddress,
            _miscAddress,
            formulaToContract(_formula)
        );

        curveToMarketTransition[address(curve)] = address(transition);

        emit MarketInstanceCreated(marketInstance, address(transition));

        ++marketInstance;

        return [address(curve), address(transition)];
    }
}