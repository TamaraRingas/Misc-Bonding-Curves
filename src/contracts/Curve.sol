// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/*
   ___           __              __ 
  / __\ /\ /\   /__\  /\   /\   /__\
 / /   / / \ \ / \//  \ \ / /  /_\  
/ /___ \ \_/ // _  \   \ V /  //__  
\____/  \___/ \/ \_/    \_/   \__/  
*/

import "./MISC.sol";
import "./UniswapRouter.sol";
import "./MarketTransition.sol"; 
import "../interfaces/ICurve.sol"; 
import "../libraries/LibErrors.sol";
import "../libraries/LibEvents.sol";
import "@prb-math/sd59x18/Math.sol";
import "../interfaces/IPriceFormula.sol"; 
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

contract Curve is ICurve, Ownable {

  // =================== VARIABLES =================== //

  uint256 maxThreshold;
  uint256 minThreshold;
  uint256 treasuryFee;
  uint256 public tokensSold;

  uint256 startTime;
  uint256 timeoutPeriod;
  uint256 timeoutPeriodExpiry;

  bool public curveActive;
  bool public transitionConditionsMet; 
  bool public transitioned; 
  bool public curveInitialized;
  bool public nftAccessSet;

  address uniswapRouter;
  address marketTransition;
  address treasury;

  IERC20 COLL;
  IECR10 MISC;
  IERC1155 nft;

  IPriceFormula priceFormula;

  // =================== MODIFIERS =================== //
    
//   modifier isActive() {
//     if (curveActive == false) revert LibErrors.CurvePaused();
//     _;
//   } 

  /// @notice Checks if a user is whitelisted for the current sale round
  /// @dev Gets the currentnftStage and checks if the user has a balance of the correcponding nft in their wallet
  modifier isEligible() {
    if (curveActive == false) revert LibErrors.CurvePaused();
      if (nftAccessSet) {
          if (keccak256(bytes(currentnftStage)) == keccak256(bytes("Black"))) {
          require(nft.balanceOf(msg.sender, BLACK_nft_ID) > 0, "nftRequired");
          _;
      }
      if (keccak256(bytes(currentnftStage)) == keccak256(bytes("Gold"))) {
          require(
              nft.balanceOf(msg.sender, BLACK_nft_ID) > 0 ||
                  nft.balanceOf(msg.sender, GOLD_nft_ID) > 0,
              "nftRequired"
          );
          _;
      }
      if (keccak256(bytes(currentnftStage)) == keccak256(bytes("Silver"))) {
          require(
              nft.balanceOf(msg.sender, BLACK_nft_ID) > 0 ||
                  nft.balanceOf(msg.sender, GOLD_nft_ID) > 0 ||
                  nft.balanceOf(msg.sender, SILVER_nft_ID) > 0,
              "nftRequired"
          );
          _;
      }
      if (keccak256(bytes(currentnftStage)) == keccak256(bytes("None"))) {
          _;
      }
    }
    _;
  }

  // =================== CONSTRUCTOR =================== //

  constructor(
        address _collateralAddress,
        address _miscAddress,
        address _nftAddress,
        address _treasuryAddress,
        address _uniswapRouter,
        address _marketTransition,
        address _priceFormulaContract
    ) {

        tokensSold = 0;

        treasury = _treasuryAddress;
        uniswapRouter = _uniswapRouter;
        marketTransition = _marketTransition;

        priceFormula = IPriceFormula(_priceFormula); 
        
        COLL = IERC20(_collateralAddress);
        MISC = IERC20(_miscAddress);

        nft = IERC1155(_nftAddress);

        curveActive = false; 
        transitionConditionsMet = false; 
        transitioned = false; 

        //nftStage = nftStage(true, false, false, false);
        //currentnftStage = "Black";
    }

    // =================== OWNER FUNCTIONS =================== //

    function initializeCurve(bool _nftAccessSet, int256 _maxThreshold, int256 _minThreshold, uint256 _timeoutPeriod) external onlyOwner {
        if (curveInitialized == true) revert LibErrors.CurveInitialized();

        startTime = block.timestamp;
        timeoutPeriodExpiry = startTime + _timeoutPeriod;

        maxThreshold = _maxThreshold;
        minThreshold = _minThreshold;

        activateCurve();

        nftAccessSet = _nftAccessSet;

        emit LibEvents.CurveInitialized(timeoutPeriodExpiry, startTime);
    }
    
    function pauseCurve() public {
        marketTransition = curveFactory.getMarketAddress(
            address(this)
        );
        require(
            msg.sender == marketTransition ||
            msg.sender == owner(),
            "Access Denied"
        );

        curveActive = false;

        emit LibEvents.CurvePaused(block.timestamp);
    }
    
    function activateCurve() external onlyOwner {
        curveActive = true;
        emit LibEvents.CurveActivated(block.timestamp);
    }

    // =================== VIEW FUNCTIONS =================== //

    // function getFee(int256 _price, int256 _percentFee) public pure returns (int256 fee) {
    //     int256 fee = PRBMathSD59x18.mul(
    //         PRBMathSD59x18.div(_percentFee * 1e18, 100e18),
    //         _price
    //     );
    // }

    function getFee(uint256 _price, uint256 _percentFee) public view returns (uint256 fee) {
        //fee =
    }

    function getMarketTransitionAddress() public view
        returns (address)
    {
        return curveFactory.getMarketAddress(address(this));
    }

    // =================== GENERAL FUNCTIONS =================== //

    function buyMISC(uint256 amount) external isEligible {
        //uint256 price = uint256();
    }

    function sellMISC(uint256 amount) external isEligible {

    }
}