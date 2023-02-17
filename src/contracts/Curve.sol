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
import "../interfaces/IMockERC1155.sol";
import "../interfaces/IBondingCurveCos.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Curve is ICurve {

  // =================== VARIABLES =================== //

  int256 immutable maxThreshold;
  int256 immutable minThreshold;
  int256 tokensSold;
  int256 treasuryFee;

  uint256 startTime;
  uint256 immutable timeoutPeriod;
  uint256 timeoutPeriodExpiry;

  bool public curveActive; // ToDo: Change to uint8 to save space
  bool public transitionConditionsMet; // ToDo: Change to uint8 
  bool public transitioned; // ToDo: Change to uint8 
  bool public curveInitialized;
  bool public nftAccess;

  address uniswapRouter;
  address marketTransition;
  address treasury;

  IERC20 COLL;
  MISC misc;
  NFT nft;

  // =================== MODIFIERS =================== //

  modifier unitialized() {
    if (curveInitialized == true) revert LibErrors.CurveInitialized(); 
    _;
  }
    
  modifier isActive() {
    if (curveActive == false) revert LibErrors.CurvePaused();
    _;
  }

  /// @notice Checks if a user is whitelisted for the current sale round
  /// @dev Gets the currentNFTStage and checks if the user has a balance of the correcponding NFT in their wallet
  modifier isEligible() {
      if (nftAccess) {
          if (keccak256(bytes(currentNFTStage)) == keccak256(bytes("Black"))) {
          require(NFT.balanceOf(msg.sender, BLACK_NFT_ID) > 0, "NFTRequired");
          _;
      }
      if (keccak256(bytes(currentNFTStage)) == keccak256(bytes("Gold"))) {
          require(
              NFT.balanceOf(msg.sender, BLACK_NFT_ID) > 0 ||
                  NFT.balanceOf(msg.sender, GOLD_NFT_ID) > 0,
              "NFTRequired"
          );
          _;
      }
      if (keccak256(bytes(currentNFTStage)) == keccak256(bytes("Silver"))) {
          require(
              NFT.balanceOf(msg.sender, BLACK_NFT_ID) > 0 ||
                  NFT.balanceOf(msg.sender, GOLD_NFT_ID) > 0 ||
                  NFT.balanceOf(msg.sender, SILVER_NFT_ID) > 0,
              "NFTRequired"
          );
          _;
      }
      if (keccak256(bytes(currentNFTStage)) == keccak256(bytes("None"))) {
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
        address _priceCurve
    ) {

        maxThreshold = 20000000; // ToDo set this in initialize function
        minThreshold = 5000000; // ToDo set this in initialize function
        timeoutPeriod = 150 days;// ToDo set this in initialize function

        tokensSold = 0;

        treasury = _treasuryAddress;
        uniswapRouter = _uniswapRouter;
        marketTransition = _marketTransition;

        //price = IPriceCurve(_getCurve); // ToDo this must be set based on formula choice as constructor input

        COLL = IERC20(_collateralAddress);
        misc = MISC(_miscAddress);

        NFT = IERC1155(_nftAddress);

        curveActive = false; // ToDo switch to uint8
        transitionConditionsMet = false; // ToDo switch to uint8
        transitioned = false; // ToDo switch to uint8

        //nftStage = NFTStage(true, false, false, false);
        //currentNFTStage = "Black";
    }
}